#!/usr/bin/perl
use warnings;
use strict;

# 2016/09/15 z3414771 Vivian Yean
# A script to count the number of Ns in each gene in the snptable 
# Also determine whether each gene fits one of three criteria
# 1 : contains positions with no coverage
# 2 : contains masked Ns
# 3 : contains neither - is useable
# not working perfectly
# atm only chops up a snptable into individual STM sites, and not perfectly

my $genes = "lt2_coreWODup.txt";
open (my $fh1, "<", $genes) or die "Cannot open $genes: $!";
# stores STM number, start and end of each gene in separate arrays
# index to refer to the same gene
my @stm;
my @start;
my @end;
while (my $line1 = <$fh1>){
   if ($line1 =~ /CDS/){
      my @line2 = split /\t/, $line1;
      push(@stm, $line2[1]);
      push(@start, $line2[2]);
      push(@end, $line2[3]);
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

my $dir = "STM_SNPS";
mkdir($dir) unless (-d $dir);
#pos index
my $pind = 1;
my $psize = $#end;
#stored index
my $in = 0;
my $i = 0;
#2D array?
my @index;
foreach $a (@stm){
   $index[0][$in] = $a;
   $index[1][$in] = "empty";
   $in++;
}
#works but missing 451 & the last three STM unaccounted for
my $ind = 0;
my @tmp;
foreach $a (@pos){
   $pind++;
   while ($ind <= $psize){
      if ($a <= $end[$ind] && $a >= $start[$ind]){
         push(@tmp, $pind);
         last;
      } else {
         my $str = join (',',@tmp);
         $index[1][$ind] = $str;
         @tmp = "";
         $ind++;
      }
   }
}

#print my arrays
for my $j (0 .. $#{$index[$i]} ) {
   for my $i (0 .. $#index){
      print "$index[$i][$j] ";
   }
   print "\n";
}


# print files
my $count = 0;
foreach $a (@stm){
   print "printing: $a\n";
   open (my $fh3, ">", "$dir/$a") or die "Cannot write $a: $!";
   print $fh3 $a;
   system ("less $coreTable|cut -d',' -f1$index[1][$count] >> $dir/$a");
   $count++;
}

=pod
#testing ver
my $STM = $index[0][1];
my $list = $index[1][1];
open (my $fh3, ">", "$dir/$STM") or die "Cannot write $STM: $!";
print $fh3 $STM;
system ("less $coreTable|cut -d',' -f1$list >> $dir/$STM");
close $fh3;
=cut
