package App::LMN::FileBrowserWidget;

use strict;
use warnings;
use autodie;

use utf8;

use Encode qw(decode);

use File::Spec;
use File::stat;

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

    foreach my $filename (@entries)
    {
        my $st = stat( File::Spec->catfile($dir_pathname, $filename) );
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

    return;
}

sub NEW
{
    my ( $class, $parent, $args ) = @_;
    $class->SUPER::NEW( $parent );

    my $dir_pathname = $args->{dir_pathname};
    this->{dir_pathname} = $dir_pathname;

    this->setHeaderLabels(["Name", "Size", "Date Modified",]);
    this->_populate_tree_with_files();

    return;
}

1;
