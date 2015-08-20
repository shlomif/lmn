package App::LMN;

use strict;
use warnings;

=encoding utf8

=head1 NAME

App::LMN - LMN, Shlomi Fish's ad-hoc file browser, written in Perl/Qt4.

=head1 VERSION

Version 0.0.1

=cut

our $VERSION = '0.0.1';

use QtCore4;
use QtGui4;
use App::LMN::Window;

sub main {
    my $app = Qt::Application( \@ARGV );
    my $window = App::LMN::Window();
    $window->show();
    exit $app->exec();
}

1;

=head1 SYNOPSIS

    use App::LMN;

    App::LMN::main();

=head1 DESCRIPTION

B<LMN> (from “Elemental” or “Elementary”), is an ad-hoc, incomplete, file
browser (not a full-fledged file manager as of yet) written in Perl/Qt4,
in order to subtitute for a use case of Konqueror on my laptop. What it aims
to do is allow to browse several directory trees and drag and drop media
files into media players, where they can be played. Nothing more than that,
but currently it is still incomplete, even based on these design goals.

=head1 FUNCTIONS

=head2 main()

The main function of the application (see the synopsis for details).

=head1 AUTHOR

Shlomi Fish, L<http://www.shlomifish.org/> .

=head1 BUGS

Please report any bugs or feature requests to C<bug-app-lmn at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=App-LMN>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc App::LMN

=head1 ACKNOWLEDGEMENTS

Ynon Perek, for promoting Qt in Israel, and for commenting on an
early version of this code. His advice was taken into consideration, but
not fully implemented yet.

=head1 COPYRIGHT & LICENSE

Copyright 2010 Shlomi Fish.

This program is distributed under the MIT (X11) License:
L<http://www.opensource.org/licenses/mit-license.php>

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

=cut

1; # End of Module::Format
