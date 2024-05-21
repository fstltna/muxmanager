#!/usr/bin/perl
use strict;
use warnings;

use UI::Dialog;
use Term::ReadKey;
use Term::ANSIScreen qw(cls);
use File::Fetch;

my $MUXCommand = "/usr/bin/telnet -E mekcity.com 3067";
my $LESSCMD = "/usr/bin/less";
my $WhatIsFile = "/home/btmux/muxmanager/whatisbtmux.txt";
my $MUXLinks = "/home/btmux/muxmanager/btmuxlinks.txt";

###################################################
# No changes below here
###################################################


my $EMP_ver = "1.0.0";
$ENV{'LESSSECURE'} = '1';	# Disables exiting to shell in LESS

my $clear_screen = cls();

my $d = new UI::Dialog ( backtitle => "BattleTech MUX v$EMP_ver", height => 20, width => 65, listheight => 5,
	order => [ 'ascii', 'cdialog', 'xdialog' ]);

my $windowtitle = "Welcome to BattleTech MUX!";
my $enjoyedtitle = "We hope you enjoyed BattleTech MUX!";
my $introtext =
"BattleTech MUX is a classic multiuser game set in the BattleTech universe. Compete against other players or bots in the simulators in real-time...";

$d->msgbox( title => $windowtitle, text => $introtext );

if (($d->state() eq "ESC") || ($d->state() eq "CANCEL"))
{
	exit 0;
}

my $menuselection = "";


sub MainMenu
{
	$menuselection = $d->menu( title => "BattleTech MUX Menu", text => "Select one:",
                            list => [ '1', 'Play BTMUX',
                                      '2', 'What is BTMUX',
                                      '3', 'BTMUX Links',
                                      'q', 'Quit BTMUX' ] );
}

print $clear_screen;

while (-1)
{
	MainMenu();
	if (($menuselection eq "CANCEL") || ($menuselection eq "ESC") || ($menuselection eq "") || ($menuselection eq "q") || ($menuselection eq "Q"))
	{
		exit 0;
	}
	if ($menuselection eq "1")
	{
		print $clear_screen;
		system("$MUXCommand");
		print "--[ Press Enter To Continue ]--";
		my $usrword = <STDIN>;
	}
	elsif ($menuselection eq "2")
	{
		print $clear_screen;
		system("$LESSCMD $WhatIsFile");
	}
	elsif ($menuselection eq "3")
	{
		print $clear_screen;
		system("$LESSCMD $MUXLinks");
	}
}

exit 0;
