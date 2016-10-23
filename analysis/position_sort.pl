#!/usr/bin/perl
use warnings;
use strict;

#2016/09/17 Vivian Yean z3414771
#this script takes a list of the core gene boundaries and the ptt file to sort which are the core genes
#core genes saved as core.ptt
#this particular script works on no coverage areas
#based heavily on between.pl, it's basically the same thing but with changed file stuff

my $genes = "core.bed";
open (my $fh1, "<", $genes) or die "Cannot open $genes: $!";
# stores STM number, start and end of each gene in separate arrays
# index to refer to the same gene
my @stm;
my @pStart;
my @pEnd;
while (my $line1 = <$fh1>){
   if ($line1 =~ /gene/){
      chomp $line1;
      my @line2 = split /\t/, $line1;
      push(@stm, $line2[3]);
      push(@pStart, $line2[1]);
      push(@pEnd, $line2[2]);
   }
}
close $fh1;

#takes in list to identify which positions are in the core regions
#compares the location to the arrays of position start and end
#prints out positions in core
# > into new file
my @pos;
#reads from argument
my $list = "list";
open (my $f3, "<", $list) or die "Cannot open $list: $!";
while (my $posLine = <$f3>){
   chomp ($posLine);
   push (@pos, $posLine);
}
my @index;
my $jSize = $#pEnd;
my $j = 0;
foreach $a (@pos){
   while($j <= $jSize){
      #case if in segment
      if ($a <= $pEnd[$j] && $a >= $pStart[$j]){
        print "\n$stm[$j]\n";
        print "$a\n";
         last;
      #advance the segments! if last segment then it isn't in the segment
      } elsif ($a > $pEnd[$j] && $a > $pStart[$j] ){
         if ($j < $jSize){
            $j++;
#            print "\n$stm[$j]\n";
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
