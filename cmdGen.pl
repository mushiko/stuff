#!/usr/bin/perl 
use warnings;
use strict;

#2016/03/10 Vivian Yean z3414771
#this script takes a file containing the SRR (or otherwise, probably can modify)
#and puts it into the snpfilt.pl command to be appended to the batch files
#the file name is because i was angry

my $file = "SRRNum";
open(my $fileHandle, "<", $file) or die "Cannot open: $file";
while (my $SRR = <$fileHandle>){
   $SRR =~ s/\n//;
   print "snpfilt.pl pipeline ${SRR}_O /srv/scratch/z3459995/Second/$SRR/${SRR}_1.fastq.gz /srv/scratch/z3459995/Second/$SRR/${SRR}_2.fastq.gz /srv/scratch/z3459995/Second/LT2.fasta \n\n";
}
close $fileHandle;

