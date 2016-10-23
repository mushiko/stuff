#!/usr/bin/perl
use warnings;
use strict;

#2016/09/18 Vivian Yean z3414771
#generates a file using criteria_set.pl and assigns criteria
# 1 : Contains no coverage position(s)
# 2 : Contains Ns
# 3 : Useable

my $file = $ARGV[0];
#print "Creating file...\n";
#system("perl criteria_set.pl > $file");
open (my $fh1, "<", $file) or die "Cannot open $file: $!";

#print "Generating output...\n";
while (my $line = <$fh1>){
   chomp $line;
#  print "$line\n";
   my @stm = split /\t/, $line;
   print "$stm[0]:\t";
   if ($stm[1] eq "NC"){
      print "1\n";
   } elsif ($stm[1] > 0){
      print "2 - $stm[1] bases\n";
   } else {
      print "3\n";
   }
}
