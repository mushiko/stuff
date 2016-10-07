#!/usr/bin/perl
use warnings;
use strict;

#2016/09/17 Vivian Yean z3414771
#produces output of number of N[1-9]s
#NC denotes no coverage positions in that certain gene


my $tableDir = "STM_SNPS";

my $genes = "lt2_coreSeg.txt";
open (my $fh1, "<", $genes) or die "Cannot open $genes: $!";
# stores STM
#
my @stm;
while (my $line1 = <$fh1>){
   if ($line1 =~ /\d/){
      my @line2 = split /\t/, $line1;
      push(@stm, $line2[0]);
   }
}
close $fh1;

my $list = $ARGV[0];
my $sList = "STMList";
system("less $list|grep Seg|uniq > $sList");

my @noCov;
open (my $fh2, "<", $sList) or die "Cannot open $sList: $!";
while(my $line2 = <$fh2>){
   chomp $line2;
   push (@noCov, $line2);
}
close $fh2;

foreach $a (@stm){
   my $file = "$tableDir/$a";
   my $name = 'Seg' . $a;
   print "$name\t";
   if ($name ~~ @noCov){
      print "NC\t";
   }
   system("less $file | grep -o [ATCG][1-9]| wc -l");
}
