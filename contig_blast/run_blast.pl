#!/usr/bin/perl
use warnings;
use strict;

#2016/10/12 Vivian Yean z3414771
#blastn -query contig.fasta -db dbname -out output

my @stm = `ls loci`;
my @strains = `ls contigs`;

foreach $a (@stm){
   chomp $a;
   print $a."\n";
   foreach $b (@strains){
      chomp $b;
      print "Running $b\n";
      system ("blastn -query contigs/$b -db loci/$a/${a}db -out loci/$a/$b.out");
   }
}
