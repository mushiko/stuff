#!/usr/bin/perl
use warnings;
use strict;

# 2016/09/15 z3414771 Vivian Yean
# A script to count the number of Ns in each gene in the snptable 
# Also determine whether each gene fits one of three criteria
# 1 : contains positions with no coverage
# 2 : contains masked Ns
# 3 : contains neither - is useable
# takes a core snptable as stdin
#woefully incomplete
#idk how to handle the data structure, array of arrays?
#idk how to print
#idk how to store the thing properly
#come back to this maybe one day

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
      @pos = split /,/, $line3;
   }
}
close $fh2;
shift @pos;

my $dir = "STM_SNPS";
mkdir($dir) unless (-d $dir);
#2d array index
my $i = 0;
my $j = 0;
#pos index
my $pind = 1;
my $psize = $#end;
#stored index
my $in = 0;
#2D array?
my @index;
foreach $a (@stm){
   $index[0][$in] = $a;
   $index[1][$in] = 0;
   $in++;
}
#works but missing 451; the last three unaccounted for
my $ind = 0;
my @tmp;
foreach $a (@pos){
   $pind++;
   while ($ind < $psize){
      if ($a <= $end[$ind] && $a >= $start[$ind]){
         push(@tmp, $pind);
         last;
      } elsif ($a > $end[$ind] && $a > $start[$ind]){
#         if ($ind < $psize){
            my $str = join (',',@tmp);
            $index[1][$ind] = $str;
            @tmp = "";
            $ind++;
#         } else {
#            last;
#         }
      # nothing enters this case  
      } elsif ($a < $end[$ind] && $a < $start[$ind]){
         last;
      }
   }
}


#basically, attach the position indexes to the second line as a string
#this takes out the string, adds one, pushes it back
#use this as template
#now just need the logic working
=pod
my $str = $index[1][1];
my $join = "H";
my $new = join (',', $str,$join);
$index[1][1] = $new;
=cut

#print my arrays
for my $j (0 .. $#{$index[$i]} ) {
   for my $i (0 .. $#index){
      print "$index[$i][$j] ";
   }
   print "\n";
}
#open (my $fh3, ">", "$dir/$STM[$ind]") or die "Cannot write $a: $!";
#sample line, prolly final will be something like that
#system("less $coreTable|cut -d"," -f$list > $dir/$STM");






