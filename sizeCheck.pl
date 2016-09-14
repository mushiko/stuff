#!/usr/bin/perl

use warnings;
use strict;

#2016/03/11 Vivian Yean z3414771
#this script takes in a list of SRR numbers and check the file size 
#scaffolds.fasta and snpfilt_results_contigs.csv
#to make sure that it is data on S. Typhimurium
#and make a file containing a list of the relevant SRR numbers

my $input = "SRRNum";
my $typhi = "SRR_Typhimurium_old";
my $not = "SRR_not";
open (my $fh1, "<", $input) or die "Cannot open: $input";
open (my $fh2, ">", $typhi) or die "Cannot write: $typhi";
open (my $fh3, ">", $not) or die "Cannot write: $not";
while (my $SRR = <$fh1>){
   $SRR =~ s/\n//;
   my $folder = "${SRR}_O";
   my $csvSize = -s "$folder/snpfilt_results_contigs.csv";
   my $scaffoldSize = -s "$folder/scaffolds.fasta";
   if ($csvSize <= 165000 && $scaffoldSize <= 5500000 && $scaffoldSize >= 4000000){
      print $fh2 "$SRR\n";
#      print $fh2 "$csvSize\n";
#     print $fh2 "$scaffoldSize\n\n";
   } else {
      print $fh3 "$SRR\n";
#print $fh3 "$csvSize\n";
#     print $fh3 "$scaffoldSize\n\n";
   }
}
close $fh1;
close $fh2;
close $fh3;
