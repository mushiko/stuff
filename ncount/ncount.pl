#!/usr/bin/perl

use strict;
use warnings;

# 2016/05/12 Vivian Yean z3414771
# count the number on Ns in each line of a snptable
# http://stackoverflow.com/questions/1444009/how-can-i-extract-substrings-from-a-string-in-perl
my $input = $ARGV[0]; 
open (my $fh1, "<", $input) or die "Cannot open $input: $!\nUsage : perl ncount.pl <snptable.csv>";
while (my $line = <$fh1>){
   if ($line =~ /\_O/){
      my ($SRR, $bases) = split(/,/, $line, 2);
      my @seq = split /,/, $bases;
      print "$SRR\n";
      my $count = 0;
      foreach $a (@seq){
          if ($a =~ /N/){
             $count++;
          }
      }
      print "Total N = $count\n";
#old testing line but tbh would've done the same thing as all the code above
#oops lol
#      system("less $input|grep ^$SRR|grep -o N|wc -l");
   }
}

close $fh1;
