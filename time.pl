#!/usr/bin/perl

#use warnings;
#use strict;
use File::stat;
use Time::localtime;
use Date::Parse;

# 2016/03/29 Vivian Yean z3414771
# In which Viv tries to identify the sequences that are taking longest to run
# http://stackoverflow.com/questions/4460610/how-can-i-get-the-difference-of-two-timestamps-using-perl
# http://www.perlmonks.org/?node=How%20do%20I%20get%20a%20file%27s%20timestamp%20in%20perl%3F
my $ref = "SRR_Typhimurium";
open (my $fh, "<", $ref) or die "Cannot open: $ref";
while (my $SRR = <$fh>) {
   print "$SRR";
   $SRR =~ s/\n//;
   my $cgpos = "cgpos_${SRR}_O.tmp";
   my $cposF = "cposF_${SRR}_O.tmp";
#  print $cgpos;
#  print $cposF;
   $date_cgpos = ctime(stat($cgpos)->mtime);
   $date_cposF = ctime(stat($cposF)->mtime);
#  print $date_cgpos;
#  print "\n";
#  print $date_cposF;
   my $s1 = str2time($date_cgpos);
   my $s2 = str2time($date_cposF);

   print $s2 - $s1, " seconds\n\n";
}
close $fh;
