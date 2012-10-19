package App::LMN::FileBrowserWidget;

use strict;
use warnings;
use autodie;

use utf8;

use Encode qw(decode);

use File::Spec;
use File::stat;

use URI::file;

use QtCore4;
use QtGui4;

use QtCore4::isa qw( Qt::TreeWidget );
use QtCore4::slots update => [];

sub dir_pathname
{
    return this->{dir_pathname};
}


sub _populate_tree_with_files
{
    my $dir_pathname = this->dir_pathname;

    my $dh;
    opendir $dh, $dir_pathname;

    my @entries = sort (File::Spec->no_upwards(readdir($dh)));

    closedir ($dh);

    my $item_count = 0;
    foreach my $filename (@entries)
    {
        my $full_path = File::Spec->catfile($dir_pathname, $filename);
        my $st = stat($full_path);
        this->addTopLevelItem(
            Qt::TreeWidgetItem(
                [
                    decode('UTF-8', $filename),
                    $st->size(),
                    scalar(localtime($st->mtime()))
                ],
                Qt::TreeWidgetItem::Type()
            )
        );
    }
    continue
    {
        $item_count++;
    }

    return;
}

sub mimeTypes
{
    return ['text/uri-list', 'text-xdnd-username'];
}

sub mimeData
{
    my ($indexes) = @_;

    my $dir_pathname = this->dir_pathname;

    my $mime_data = Qt::MimeData();

    my $encoded_data_uris = Qt::ByteArray();
    my $encoded_data_users = Qt::ByteArray();
    my $data_stream_users = Qt::DataStream($encoded_data_users, Qt::IODevice::WriteOnly());
    my $data_stream_uris = Qt::DataStream($encoded_data_uris, Qt::IODevice::WriteOnly());

    my $username = getpwuid($<);

    foreach my $item (@$indexes)
    {
        # For the << operator.
        no warnings 'void';

        $data_stream_users << $username;

        $data_stream_uris <<
            (URI::file->new(
                File::Spec->catfile(
                    $dir_pathname,
                    $item->data(0, Qt::DisplayRole()),
                )
            )->as_string());
    }

    $mime_data->setData('text/uri-list', $encoded_data_uris);
    $mime_data->setData('text-xdnd-username', $encoded_data_users);

    return $mime_data;
}

sub NEW
{
    my ( $class, $parent, $args ) = @_;
    $class->SUPER::NEW( $parent );

    my $dir_pathname = $args->{dir_pathname};

    this->{dir_pathname} = $dir_pathname;

    this->setHeaderLabels(["Name", "Size", "Date Modified",]);
    this->_populate_tree_with_files();

    this->setSelectionMode(Qt::AbstractItemView::ExtendedSelection());
    this->setDragEnabled(1);
    this->setDragDropMode(Qt::AbstractItemView::DragOnly());

    return;
}

1;
