#!/usr/bin/perl
use warnings;
use strict;


#2016/09/19 Vivian Yean z3414771
#i seek death
#and a new name for my death files
#outputs number of genes with Ns for each isolate

my $iso = "dataList";
open (my $fh1, "<", $iso) or die "Cannot open $iso: $!";
# stores STM number, start and end of each gene in separate arrays
# index to refer to the same gene
my @isolates;
while (my $line1 = <$fh1>){
   chomp $line1;
   push(@isolates, $line1);
}
close $fh1;

my $genes = "lt2_coreWODup.txt";
my $dir = "STM_SNPS";
open (my $fh2, "<", $genes) or die "Cannot open $genes: $!";
# stores STM number, start and end of each gene in separate arrays
# index to refer to the same gene
my @stm;
while (my $line1 = <$fh2>){
   if ($line1 =~ /CDS/){
      my @line2 = split /\t/, $line1;
      push(@stm, $line2[1]);
   }
}
close $fh2;

#for some reason out of the Anastasia's dataset
#this loop doesn't process 4594 and 4595 
#this is the second loop to do this
#so i put atcg = 2 initially
#because i know those two have no Ns
my @count;
my $in = 0;
foreach $a (@isolates){
   $count[0][$in] = $a;
   my $n = 0;
   my $atcg = 2;
   foreach $b (@stm){
      open (my $fh, "<", "$dir/$b") or die "Cannot open $b: $!";
      while (my $line = <$fh>){
         if ($line =~ /^$a/){
            chomp $line;
            if ($line =~ ","){
               my ($lol, $bases) = split(/,/, $line, 2);
#              print "$b: $lol :$bases\n";
               if ($bases =~ /\d/){
                  $n++;
               } else {
                  $atcg++;
               }
            } else {
               $atcg++;
            }
#           print "$n - $atcg\n";
         }
      }
      close $fh;
   }
   $count[1][$in] = $n;
   $count[2][$in] = $atcg;
   $in++;
}
#=pod
#print arrays
my $i = 0;
for my $j (0 .. $#{$count[$i]}){
   for my $i (0 .. $#count){
      print "$count[$i][$j] ";
   }
   print "\n";
}
#=cut
