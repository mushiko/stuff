#!/usr/bin/perl
use warnings;
use strict;

#written to test 2d arrays
my @lol;
for my $i (0..20){
   for my $j (0..20){
   $lol[$i][$j] = 1;
   }
}

for my $i (0..$#lol){
   for my $j (0 .. $#{$lol[$i]} ) {
      print "$lol[$i][$j] ";
   }
   print "\n";
}

=pod
for (my $row = 0; $row <10; $row++){
   for (my $col = 0; $col < 10; $col++){
      print "$lol[$row][$col]\t";
   }
   print "\n";
}
=cut
#print $lol[0][0];
