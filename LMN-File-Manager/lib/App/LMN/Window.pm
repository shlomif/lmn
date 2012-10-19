package App::LMN::Window;

use strict;
use warnings;
use autodie;

use utf8;

use File::Spec;
use File::stat;

use QtCore4;
use QtGui4;

use QtCore4::isa qw( Qt::MainWindow );
use QtCore4::slots windowExit => [];

use App::LMN::FileBrowserWidget;

sub windowExit() {
    exit(0);
}

sub NEW {
    my ( $class, $parent ) = @_;
    $class->SUPER::NEW( $parent );

    my $layout = Qt::GridLayout();
    my $tab_widget = Qt::TabWidget();

    foreach my $dir_pathname (@ARGV)
    {
        $tab_widget->addTab(
            App::LMN::FileBrowserWidget(
                this,
                {
                    dir_pathname => $dir_pathname,
                }
            ),
            $dir_pathname,
        );
    }

    my $num_columns = 1;

    $layout->addWidget($tab_widget, 0, 0, 1, $num_columns);

    my $widget = Qt::Widget();
    $widget->setLayout($layout);
    this->setCentralWidget($widget);

    this->setWindowTitle(this->tr(q{Shlomif's Ad-Hoc File Manager}));

    my $fileMenu = this->menuBar()->addMenu(this->tr("&File"));
    my $exitAction = Qt::Action(this->tr("E&xit"), this);

    this->connect($exitAction, SIGNAL 'triggered()',
        this, SLOT 'windowExit()');

    $fileMenu->addAction($exitAction);

    return;
}

1;
