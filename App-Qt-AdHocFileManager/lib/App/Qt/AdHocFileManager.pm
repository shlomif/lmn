package App::Qt::AdHocFileManager;

use strict;
use warnings;

use QtCore4;
use QtGui4;
use App::Qt::AdHocFileManager::Window;

sub main {
    my $app = Qt::Application( \@ARGV );
    my $window = App::Qt::AdHocFileManager::Window();
    $window->show();
    exit $app->exec();
}

main();
1;
