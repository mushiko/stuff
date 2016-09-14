#!/usr/bin/perl

use strict;
use warnings;

#2016/03/16 Vivian Yean z3414771
#because snptable isn't working i'm writing this to checkthe sizes of the softlinked files
#wait how do you open all the folders in perl

my $input = "SRR_Typhimurium";
my $check = "check";
#ur check should be SRR_Typhimurium u noob

open (my $fh1, "<", $input) or die "Cannot open: $input";
open (my $fh2, ">", $check) or die "Cannot write: $check";
while (my $SRR = <$fh1>){
   $SRR =~ s/\n//;
   my $folder = "${SRR}_O";
   my $csvSize = -s "$folder/snpfilt_results_contigs.csv";
   my $scaffolds = -s "$folder/scaffolds.fasta";
   print $fh2 "$SRR\n";
   print $fh2 "$csvSize\n";
   print $fh2 "$scaffolds\n\n";

}
close $fh1;
close $fh2;
