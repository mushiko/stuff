#!/usr/bin/perl
use warnings;
use strict;


#2016/09/17 Vivian Yean z3414771
#generates a list of bases with no coverage
#requires death.pl

#file containing names of the isolates
my $datalist = "dataList";
my $datadir = "data";
open (my $fh1, "<", $datalist) or die "Cannot open $datalist: $!";
my @isolates;
while (my $line = <$fh1>){
   chomp $line;
   push(@isolates, $line);
   
#@isolates = split /\n/, $line;
}
#generate segments
#run death.pl
#print out list of positions in a giant jumble
foreach $a (@isolates){
   system("less $datadir/$a/aln_contigs.cigarx|cut -f2,3|grep ^[0-9]|sort -n > segments");
   print "Printing: $a\n";
   system("perl death.pl >> tmp");
}
#sorts the tmp file and gets a list of unique positions
#removes temp files
print "Combining files...\n";
system("cat tmp |sort -n |uniq>list");
system("rm tmp");
system("rm segments");
print "Done!! Wow Viv!\n";
