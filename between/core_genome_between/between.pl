#!/usr/bin/perl
use warnings;
use strict;

#2016/10/19 Vivian Yean z3414771
#this script takes a list of the core gene boundaries and the ptt file to sort which are the core genes
#core genes saved as core.ptt

my @pEnd;
my @pStart;
my $seg = "lt2_coreSeg.txt";
open (my $fh, "<", $seg) or die "Cannot open: $!\n";
while (my $line = <$fh>){
   if ($line =~ /\d/){
      chomp $line;
      my @pos = split /\t/, $line;
      push (@pStart, $pos[3]);
      push (@pEnd, $pos[4]);
   }
}

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
