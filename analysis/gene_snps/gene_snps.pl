#!/usr/bin/perl
use warnings;
use strict;

# 2016/09/15 z3414771 Vivian Yean
# A script to count the number of Ns in each gene in the snptable 
# Also determine whether each gene fits one of three criteria
# 1 : contains positions with no coverage
# 2 : contains masked Ns
# 3 : contains neither - is useable
# SANDEEP SAVED ME IT WORKS
#SLIGHTLY MODIFIED TO HANDLE DIFF THINGS

my $genes = "core.bed";
open (my $fh1, "<", $genes) or die "Cannot open $genes: $!";
# stores STM number, start and end of each gene in separate arrays
# index to refer to the same gene
my @stm;
my @start;
my @end;
while (my $line1 = <$fh1>){
   if ($line1 =~ /gene/){
      chomp $line1;
      my @line2 = split /\t/, $line1;
      push(@stm, $line2[3]);
      push(@start, $line2[1]);
      push(@end, $line2[2]);
   }
}
close $fh1;

my $coreTable = $ARGV[0];
my @pos;
open (my $fh2, "<", $coreTable) or die "Cannot open $coreTable: $!";
while (my $line3 = <$fh2>){
   if ($line3 =~ /,\d/){
      chomp $line3;
      @pos = split /,/, $line3;
   }
}
close $fh2;
shift @pos;

my $dir = "CORE_SNPS";
mkdir($dir) unless (-d $dir);
#pos index
my $pind = 1;
my $psize = $#end;
print "psize = $psize\n";
#stored index
my $ind = 0;
my %hm = (); 
foreach $a (@pos){
   $pind++;
   $ind = 0;
   while ($ind <= $#start){
      if ($a <= $end[$ind] && $a >= $start[$ind]){
         my $var = $hm{$a}; 
         if (! exists($hm{$ind})){
            $hm{$ind} = ""; 
         }
         $hm{$ind} = $hm{$ind}  . "," . $pind; 
         print "a= $a\n";
         print "pind= $pind\n";
         print "ind= $ind\n";
      }
         $ind++;
   }
}

foreach my $key (sort{$a <=> $b} keys %hm){
   print $key . " " . $hm{$key}."\n"; 
}

# print files
my $count = 0;
foreach $a (@stm){
   print "printing: $a\n";
   open (my $fh3, ">", "$dir/$a") or die "Cannot write $a: $!";
   print $fh3 $a; 
   my $hm_idx = $count; 
   if (!exists($hm{$hm_idx})){
      system ("cat $coreTable|cut -d',' -f1 >> $dir/$a");
   } else {
      system ("cat $coreTable|cut -d',' -f1$hm{$hm_idx} >> $dir/$a");
   }
   $count++;
}
