#!/usr/bin/perl

use warnings;
use strict;

# 2016/10/12 Vivian Yean z3414771
# grabs contig files from softlinked directories (in softlinks)
# puts them into a directory called contigs, renames them to strain number

my $dir = "contigs";
mkdir($dir) unless (-d $dir);
my @ls = `ls softlinks|grep _O`;
foreach $a (@ls){
   chomp $a;
   my $b = $a;
   $b =~ s/_L008_O//;
   print "Getting contig: $b\n";
   system("cp softlinks/$a/contigs.fasta $dir/$b.fasta");
}
