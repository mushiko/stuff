#!/usr/bin/perl
use warnings;
use strict;

#2016/09/09 Vivian Yean z3414771
#Script to find the size of the contigs and print out the ones over 1000bp
#> into new file
#flt_contigs.gz converted with convert_fasta.pl as input


my $file = $ARGV[0];
my @contigSize;
my @contig;
my $min = 1000;
open (my $fh, "<", $file) or die "Cannot open $file: $!\n";
while (my $line = <$fh>){
   if ($line =~ m/^>/){
      my $next = <$fh>;
      my $size = length($next);
      if ($size > $min){
         print $line;
         print $next;
      }
   }

}
