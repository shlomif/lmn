package App::Qt::AdHocFileManager::Window;

use strict;
use warnings;
use autodie;

use File::Spec;
use File::stat;

use QtCore4;
use QtGui4;

use QtCore4::isa qw( Qt::Widget );
use QtCore4::slots update => [];

sub addendLineEdit() {
    return this->{addendLineEdit};
}

sub addend2LineEdit() {
    return this->{addend2LineEdit};
}

sub setAddendLineEdit() {
    return this->{addendLineEdit} = shift;
}

sub setAddend2LineEdit() {
    return this->{addend2LineEdit} = shift;
}

sub resultLineEdit() {
    return this->{resultLineEdit};
}

sub setAccessLineEdit() {
    return this->{resultLineEdit} = shift;
}

sub update {
    this->resultLineEdit->setText(
        this->addendLineEdit()->text() + this->addend2LineEdit->text()
    );
}

sub _populate_tree_with_files
{
    my ($files_tree, $dir_pathname) = @_;

    my $dh;
    opendir $dh, $dir_pathname;

    my @entries = sort (File::Spec->no_upwards(readdir($dh)));

    closedir ($dh);

    foreach my $filename (@entries)
    {
        my $st = stat( File::Spec->catfile($dir_pathname, $filename) );
        $files_tree->addTopLevelItem(Qt::TreeWidgetItem([$filename, $st->size(), scalar(localtime($st->mtime()))], Qt::TreeWidgetItem::Type()));
    }

    return;
}


sub NEW {
    my ( $class, $parent ) = @_;
    $class->SUPER::NEW( $parent );

    my $addendGroup = Qt::GroupBox();

    my $addendLabel = Qt::Label(this->tr('Addend #1:'));

    my $addend2Group = Qt::GroupBox();

    my $addend2Label = Qt::Label(this->tr('Addend #2:'));

    this->setAddendLineEdit( Qt::LineEdit("1") );
    this->setAddend2LineEdit( Qt::LineEdit("1") );

    my $resultGroup = Qt::GroupBox();

    my $resultLabel = Qt::Label(this->tr('Result:'));

    this->setAccessLineEdit( Qt::LineEdit() );

    this->resultLineEdit->setReadOnly(1);

    my $addendLayout = Qt::GridLayout();
    $addendLayout->addWidget($addendLabel, 0, 0);
    $addendLayout->addWidget(this->addendLineEdit, 1, 0, 1, 2);
    $addendGroup->setLayout($addendLayout);

    this->addendLineEdit->setValidator(Qt::DoubleValidator(5,
            999.0, 2, this->addendLineEdit));

    my $addend2Layout = Qt::GridLayout();
    $addend2Layout->addWidget($addend2Label, 0, 0);
    $addend2Layout->addWidget(this->addend2LineEdit, 1, 0, 1, 2);
    $addend2Group->setLayout($addend2Layout);

    this->addend2LineEdit->setValidator(Qt::DoubleValidator(5,
            999.0, 2, this->addend2LineEdit));

    my $resultLayout = Qt::GridLayout();
    $resultLayout->addWidget($resultLabel, 0, 0);
    $resultLayout->addWidget(this->resultLineEdit, 1, 0, 1, 2);
    $resultGroup->setLayout($resultLayout);


    my $layout = Qt::GridLayout();
    $layout->addWidget($addendGroup, 0, 0);
    $layout->addWidget($addend2Group, 0, 1);
    $layout->addWidget($resultGroup, 0, 2);

    my $update_button = Qt::PushButton("Update");
    $layout->addWidget($update_button, 1, 0, 1, 2);

    my $files_tree = Qt::TreeWidget();

    $files_tree->setHeaderLabels(["Name", "Size", "Date Modified",]);

    my $dir_pathname = shift(@ARGV);

    this->_populate_tree_with_files($files_tree, $dir_pathname);

    $layout->addWidget($files_tree, 2, 0, 1, 3);

    this->setLayout($layout);

    this->connect($update_button, SIGNAL 'clicked()',
        this, SLOT 'update()');

    this->setWindowTitle(this->tr('Mini Calculator'));

    this->update();
}

1;
