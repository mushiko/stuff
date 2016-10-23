#!/usr/bin/perl
use warnings;
use strict;

# 2016/10/12 Vivian Yean z3414771
# subtracts 1 from the start cut positions because bedtools has an offset of 1
# outputs new .bed file to stout
my $file = "core.bed";

open (my $fh, "<", $file) or die "PLEASE VIV $!";
while (my $line = <$fh>){
   chomp $line;
   my @lines = split /\t/, $line;
   $lines[1]--;
   my $str = join "\t", @lines;
   print $str."\n";
}
