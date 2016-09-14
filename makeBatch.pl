#!/usr/bin/perl

use warnings;
use strict;

#2016/03/10 Vivian Yean z3414771
#so this script atm when run makes 14 batch files that you can 
#append the snpfilt.pl commands to
#in future maybe add a stdin of number of lines and divide (?)
#by 20 to make a automatic number of batch files
#look in testStuff/test.pl for the subtraction loop for input batch creation!!!

my $i=1;
while ($i < 15){
   my $file = "batch$i";
   open (my $fileHandle, '>', $file) or die "Could not open $file:$!";
   print $fileHandle "\#!/bin/bash

#PBS -N BATCH$i
#PBS -l nodes=1:ppn=1
#PBS -l vmem=60gb
#PBS -l walltime=96:00:00
 
cd \$PBS_O_WORKDIR\n\n";
   close $fileHandle;
   $i++;
}
