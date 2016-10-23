#!/usr/bin/perl
use warnings;
use strict;

#2016/10/12 Vivian Yean z3414771
#blastn -query contig.fasta -db dbname -out output
#trying to run it concurrently

my @stm = `ls loci`;
my @strains = `ls contigs`;


foreach $a (@stm){
   chomp $a;
   my $pbs = $a."pbs";
   open (my $fh, ">", $pbs) or die "Cannot Write:$!\n";
   print $fh "#!/bin/bash

#PBS -N run_blast$a
#PBS -l nodes=1:ppn=1
#PBS -l vmem=24gb
#PBS -l walltime=6:00:00
#PBS -j oe
#PBS -M z3414771\@ad.unsw.edu.au
#PBS -m ae

cd \$PBS_O_WORKDIR\n";
   foreach $b (@strains){
      chomp $b; 
      print $fh "blastn -query contigs/$b -db loci/$a/${a}db -out loci/$a/$b.out\n";
   }
}
