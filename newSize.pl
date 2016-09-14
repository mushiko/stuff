#!/usr/bin/perl

use warnings;
use strict;


my $typhi = "SRR_Typhimurium_old";
open (my $fh2, "<", $typhi) or die "Cannot write: $typhi";
while (my $SRR = <$fh2>){
   $SRR =~ s/\n//;
   my $folder = "${SRR}_O";
   my $csvSize = -s "$folder/snpfilt_results_contigs.csv";
   my $scaffoldSize = -s "$folder/scaffolds.fasta";
      print "$SRR\n";
      print "$csvSize\n";
      print "$scaffoldSize\n\n";
}
close $fh2;
