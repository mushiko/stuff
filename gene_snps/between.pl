#!/usr/bin/perl
use warnings;
use strict;

#2016/06/14 Vivian Yean z3414771
#this script takes a list of the core gene boundaries and the ptt file to sort which are the core genes
#core genes saved as core.ptt
#

#takes in a file containing a list of the core gene segment boundaries
#and splits it into two arrays
#one with the start boundaries and one with end
my $core = "/srv/scratch/z3414771/between/coreSeg";
open (my $f1, "<", $core) or die "Cannot open: $core";
my @start;
my @end;
while (my $star = <$f1>){
   my $en = <$f1>;
   my $start = substr $star, 3, 4;
   my $end = substr $en, 3, 4;
   chomp $start;
   chomp $end;
   push (@start, $start);
   push (@end, $end);
}
close $f1;

#takes in the LT2E.ptt file, which is LT2.ptt modified using split.pl to contain 
#start and end location of the STMs rather than start..end
#puts the start and end of each STM in the core genes into two arrays
my @pStart;
my @pEnd;
my $genes = "/srv/scratch/z3414771/between/LT2E.ptt";
open (my $f2, "<", $genes) or die "Cannot open: $genes";
while (my $line = <$f2>){
   if ($line =~ /STM/){
      my @lines = split /\t/, $line;
      my $stm = substr $lines[6], 3, 4;
      chomp $stm; 
      #before it was i <= 63, which is the same as i < 64, in this case $#start = 63
      for (my $i = 0; $i <= $#start; $i++){
         if ($stm >= $start[$i] && $stm <= $end[$i]){
            my $posStart = $lines[0];
            my $posEnd = $lines[1];
            chomp ($posStart, $posEnd);
            push (@pStart, $posStart);
            push (@pEnd, $posEnd);
         }
      }
   }
}
close $f2;

#takes in snpTable Output to identify which snps are in the core regions
#compares the location to the arrays of position start and end
#puts the snps in the core regions into a array @index, then cut pipe to produce 
#modified snptable to be > into a new file
my @pos;
#reads from argument
my $snpTable = $ARGV[0];
open (my $f3, "<", $snpTable) or die "Usage: between.pl <snptable.csv>";
while (my $snpLine = <$f3>){
   if ($snpLine =~ /,\d/){
      my $posLine = $snpLine;
      @pos = split /,/, $posLine;
   }
}
shift @pos;
my @index;
my $jSize = $#pEnd;
my $j = 0;
#this is 1 because the snptable's 0th column is the seq name
my $ind = 1;
foreach $a (@pos){
   $ind++;
   while($j <= $jSize){
      #case if in segment
      if ($a <= $pEnd[$j] && $a >= $pStart[$j]){
         push(@index, $ind);
         last;
      #advance the segments! if last segment then it isn't in the segment
      } elsif ($a > $pEnd[$j] && $a > $pStart[$j] ){
         if ($j < $jSize){
            $j++;
         #this is for the last few segments, if j has reached the end
         #previously the script would not process those parts
         } else {
            last;
         }
      #case if position is smaller than start or end, 
      #so out of bounds of prev segments
      } elsif ($a < $pEnd[$j] && $a < $pStart[$j]){
         last;
      }
   }
}
#cut puts together the new snptable
my $string = join(',', @index);
system("cat $snpTable|cut -d \",\" -f1,$string");   
