#!/usr/bin/perl
use warnings;
use strict;

#2016/09/05 Vivian Yean z3414771
#based off the logic in between.pl
#takes in zstart1 and end1 of aln_contigs.cigarx cut out of the file
#splits into two arrays
#compares a full array of numbers 0..$refLength to zstart1 and end1
#and prints out whatever not in the bounds
#basically prints a list of positions with no coverage
#previously death.pl, the first of many (three)
#Me:  I wrote a script using death.pl so i can't change the name unless
#     I go through and change it all
#Dom: Accept death

#the number is the length of LT2 ref genome
#can comment out alternative line and use stdin
my $refLength = 4857432;
#my $refLength = $ARGV[0];

#shoves zstart1 and end1 into two arrays
my $segments = "segments";
#less aln_contigs.cigarx|cut -f2,3|grep ^[0-9]|sort -n > segments
my @start;
my @end;
open (my $fh, "<", $segments) or die "Cannot open: $segments $!";
while (my $line = <$fh>){
   my @lines = split /\t/, $line;
   my $posStart = $lines[0];
   my $posEnd = $lines[1];
   push (@start, $posStart);
   push (@end, $posEnd);
}
close $fh;

#compares it and prints whatever doesn't fit
#based off between.pl
my @pos;
for (my $i = 0; $i <= $refLength; $i++){
   push (@pos, $i);
}
my $j = 0;
my $jSize = $#start;
foreach $a (@pos){
   while ($j <= $jSize){
      if ($a <= $end[$j] && $a >= $start[$j]){
         last;
      } elsif ($a > $end[$j] && $a > $start[$j]){
         if ($j < $jSize){
            $j++;
         } else { 
            print "$a\n";
            last;
         }
      } elsif ($a < $end[$j] && $a <$start[$j]){
         print "$a\n";
         last;
      }
   }
}


