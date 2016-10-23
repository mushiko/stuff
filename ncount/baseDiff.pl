#!/usr/bin/perl

use strict; 
use warnings;

#2016/06/28 Vivian Yean z3414771
#takes in a snptable -p R csv output and finds out how many of the filtered snps match the reference
#compare output to ncount.pl

#2016/09/14
#fixed 
#the bottom part is new

my $input = $ARGV[0];
my @refsnp;
open (my $f1, "<", $input) or die "Cannot open $input: $!\nUsage: perl baseDiff.pl <snptable.csv>\n";
while (my $line = <$f1>){
   if ($line =~ /reference/){
      my ($ref, $bases) = split (/,/, $line, 2);
      @refsnp = split /,/, $bases;
   } 
   if ($line =~ /\_O/){
      my ($name, $bases) = split(/,/, $line, 2);
      my @snps = split /,/, $bases;
      my $ind = 0;
      my $diffs = 0;
      my $sames = 0;
      my $totalsnps = 0;
      print "\n$name\n";
      my $filtsnps = 0;
      my $end = $#refsnp;
      while ($ind <= $end){
         if ($snps[$ind] =~ /[ATCG][0-9]/){
            my $base = substr $snps[$ind], 0, 1;
            if ($refsnp[$ind] eq $base){
               $sames++;
               $ind++;
               
            } elsif ($refsnp[$ind] ne $base){
               $diffs++;
               $ind++;
            }
            $filtsnps++;
         } else {
            $ind++;
         }
      }
      $ind = 0;
      my $totalsames = 0;
      my $totaldiffs = 0;
      while ($ind <= $end){
         my $base = substr $snps[$ind], 0, 1;
         if ($refsnp[$ind] eq $base){
            $totalsames++;
            $ind++;   
         } elsif ($refsnp[$ind] ne $base){
            $totaldiffs++;
            $ind++;
         }
         $totalsnps++;
      }

      print "Filtered Bases:\n";
      print "total = $filtsnps\n";
      print "same = $sames\n";
      print "diff = $diffs\n";
      print "\nAll Bases:\n";
      print "total = $totalsnps\n";
      print "same = $totalsames\n";
      print "diff = $totaldiffs\n";

   }
}
