#!/usr/bin/perl
use warnings;
use strict;

#2019/09/05 Vivian Yean z3414771
#other script that is a mess
#takes in list of N7 filtered positions
#as in, take a snptable file in excel, transpose, 
#filter for N7 for one isolate, save as .csv, cut -d',' -f1

#and then shove it into an array and grep the output of no_coverage_list.pl 
#to see if the N7s match the no coverage areas of assembly
#hint: it does

#no_coverage_list.pl output 
my $input = $ARGV[0];
my @lines;
my $list = "list";
open(my $fh, "<", $list) or die "Cannot open $list $!";
while (my $line = <$fh>){
   push (@lines, $line);
}
foreach $a (@lines){
   system("less $input|grep $a");
}
