#!/usr/bin/perl
use warnings;
use strict;

# 2016/10/11 Vivian Yean z3414771
# Script takes in a processed gtt file containing only the gene info and rearranges into .bed format
# needs manual sorting of core genes

my $file = "LT2genes";
open (my $fh, "<", $file) or die "LMAO PLEASE WORK $!";

while (my $line = <$fh>){
   chomp $line;
   my @line = split /\t/, $line;
   my @line2 = split /;/, $line[-1];
   my @match = grep { /locus_tag/} @line2;
   foreach $a (@match){
      my $str = substr $a, 10;
      print "$line[0]\t$line[1]\t$line[2]\t";
      print $str."\n";
   }
}
