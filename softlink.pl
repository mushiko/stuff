#!/usr/bin/perl

use warnings;
use strict;

#2016/03/14 Vivian Yean z3414771
#takes in a file with a list of relevant SRR numbers and creates a softlink in a folder
#maybe in future take in folder and file via stdin 

my $file = "SRR_Typhimurium";
open (my $fh, "<", $file) or die "Cannot open: $file";
while (my $SRR = <$fh>){
   $SRR =~ s/\n/\_O/;
   system("ln -s /srv/scratch/z3414771/$SRR /srv/scratch/z3414771/snptablein");
}
close $fh;
