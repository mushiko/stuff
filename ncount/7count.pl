#!/usr/bin/perl
use warnings;
use strict;

#2016/10/21 Vivian Yean z3414771
#script to count N7s across the snptable 

my $file = $ARGV[0];
open (my $fh, "<", $file) or die "Cannot open file: $!\n";
while (my $line = <$fh>){
   chomp $line;
   my ($name, $bases) = split (/,/, $line, 2);
   my @seq = split /,/, $bases;
   my $count = 0;
   foreach $a (@seq){
      if ($a =~ /A7/ || $a =~ /C7/ || $a =~ /G7/ || $a =~ /T7/){
         $count++;
      }
   }
   print "$name: $count\n";
}
