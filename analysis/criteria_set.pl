#!/usr/bin/perl
use warnings;
use strict;

#2016/09/17 Vivian Yean z3414771
#produces output of number of N[1-9]s
#NC denotes no coverage positions in that certain gene


my $tableDir = "STM_SNPS";

my $genes = "lt2_coreWODup.txt";
open (my $fh1, "<", $genes) or die "Cannot open $genes: $!";
# stores STM number, start and end of each gene in separate arrays
# index to refer to the same gene
my @stm;
while (my $line1 = <$fh1>){
   if ($line1 =~ /CDS/){
      my @line2 = split /\t/, $line1;
      push(@stm, $line2[1]);
   }
}
close $fh1;

my $list = "coreList";
my $sList = "STMList";
system("less $list|grep STM|uniq > $sList");

my @noCov;
open (my $fh2, "<", $sList) or die "Cannot open $sList: $!";
while(my $line2 = <$fh2>){
   chomp $line2;
   push (@noCov, $line2);
}
close $fh2;

foreach $a (@stm){
   my $file = "$tableDir/$a";
   print "$a\t";
   if ($a ~~ @noCov){
      print "NC\t";
   }
   system("less $file | grep -o [ATCG][1-9]| wc -l");
}
