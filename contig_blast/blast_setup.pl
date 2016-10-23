#!/usr/bin/perl
use warnings;
use strict;

# 2016/10/12 Vivian Yean z3414771
# takes the output from using bedtools getfasta on the S. Typhimurium genome 
# and core2.bed files and cuts each reference STM up, puts into separate folders
# and runs makeblastdb
# makeblastdb -in ref.fasta -out dbname -dbtype nucl

#the bedtools or extract_loci.pl output
my $file = $ARGV[0];
open (my $fh, "<", $file) or die "Cannot open $file : $!\n";
my @genes;
my $dir;
my $loci = "loci";
mkdir($loci) unless (-d $loci);
while (my $line = <$fh>){
   if ($line =~ />/){
      chomp $line;
      $dir = substr $line, 1;
      print "Processing $dir\n";
      mkdir("$loci/$dir") unless (-d "$loci/$dir");
      open (my $fh2, ">", "$loci/$dir/$dir.fasta") or die "Cannot write $dir: $!";
      print $fh2 ">$dir\n"; 
      push (@genes, $dir);
   }
   if ($line !~ />/){
      open (my $fh3, ">>", "$loci/$dir/$dir.fasta") or die "Cannot write $dir: $!";
      print $fh3 $line;
   }
}

foreach $a (@genes){
   print "makeblastdb $a...\n";
   system("makeblastdb -in $loci/$a/$a.fasta -out $loci/$a/${a}db -dbtype nucl");
}

print "Done!\n";
