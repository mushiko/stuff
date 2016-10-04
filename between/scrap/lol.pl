#!/usr/bin/perl
use warnings;
use strict;

#2016/06/14 Vivian Yean z3414771
#this script takes a list of the core gene boundaries and the ptt file to sort which are the core genes
#core genes saved as core.ptt
#this is an attempt at modifying between... gave up tho

#takes in a file containing a list of the core gene segment boundaries
#and splits it into two arrays
#one with the start boundaries and one with end
my $core = "/srv/scratch/z3414771/between/coreSeg";
open (my $f1, "<", $core) or die "Cannot open: $core";
my @start;
my @end;
while (my $start = <$f1>){
   my $end = <$f1>;
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
my $genes = "/srv/scratch/z3414771/between/lt2_features.txt";
open (my $f2, "<", $genes) or die "Cannot open: $genes";
foreach $a (@start){
   while (my $line = <$f2>){
      chomp $line;
      my @lines = split /\t/, $line;
      if ($lines[0] =~ /CDS/){
         if ($lines[1] =~ /$a/){
            push (@pStart, $lines[2]);
            last;
         }
      } elsif ($lines[0] =~ /gene/){
         if ($lines[1] =~ /$a/){
            push (@pStart, $lines[2]);
            last;
         }
      } elsif ($lines[0] =~ /RBS/){
         if ($lines[1] =~ /$a/){
            push (@pStart, $lines[2]);
            last;
         }
      }
   }   
}
open ($f2, "<", $genes) or die "Cannot open: $genes";
my $j = 0;
foreach $b (@end){
   while (my $line = <$f2>){
      chomp $line;
      my @lines = split /\t/, $line;
      if ($lines[1] =~ /$b/ && $lines[0] =~ /gene/){
         $pEnd[$j] = $lines[3];
      } elsif ($lines[1] =~ /$b/ && $lines[0] =~ /RBS/){
         $pEnd[$j] = $lines[3];
      } elsif ($lines[1] =~ /$b/ && $lines[0] =~ /CDS/){
         $pEnd[$j] = $lines[3];
      }
   }   
   $j++;
}
close $f2;
print $#start;
print "\n";
print "@pStart\n";
print $#pStart;
print "\n";
print "@pEnd\n";
print $#pEnd;
