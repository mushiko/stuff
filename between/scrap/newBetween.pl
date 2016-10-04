#!/usr/bin/perl
use warnings;
use strict;

#2016/10/04 Vivian Yean z3414771
#based off between.pl, written to fix the core genome. previous between cut out each individual
#STM, this cuts out chunks of STMs according to definition by Fu et al.
#segment.txt is a very important file, don't lose it


my @pStart;
my @pEnd;
my $genes = "/srv/scratch/z3414771/between/scrap/segments.txt";
open (my $f2, "<", $genes) or die "Cannot open: $genes";
while (my $line = <$f2>){
   if ($line =~ /STM/){
      my @lines = split /\t/, $line;
      push (@pStart, $lines[2]);
      push(@pEnd, $lines[3]);
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
         #print "Yes: $a\n";
         push(@index, $ind);
         last;
      #advance the segments! if last segment then it isn't in the segment
      } elsif ($a > $pEnd[$j] && $a > $pStart[$j] ){
         if ($j < $jSize){
            $j++;
         #this is for the last few segments, if j has reached the end
         #previously the script would not process those parts
         } else {
            #print "No: $a\n";
            last;
         }
      #case if position is smaller than start or end, 
      #so out of bounds of prev segments
      } elsif ($a < $pEnd[$j] && $a < $pStart[$j]){
         #print "No: $a\n";
         last;
      }
   }
}
#cut puts together the new snptable
my $string = join(',', @index);
system("cat $snpTable|cut -d \",\" -f1,$string");   

