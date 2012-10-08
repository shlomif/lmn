package App::LMN;

use strict;
use warnings;

use QtCore4;
use QtGui4;
use App::LMN::Window;

sub main {
    my $app = Qt::Application( \@ARGV );
    my $window = App::LMN::Window();
    $window->show();
    exit $app->exec();
}

main();
1;
