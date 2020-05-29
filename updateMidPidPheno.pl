## Changes mother, father id's and pheno to 0 in FAM file
## Trailing space??

#!usr/bin/perl 

$numArgs = $#ARGV + 1;
my $filename_in = $ARGV[0];
my $filename_out = $ARGV[1];


open (FH, $filename_in) || die "cannot open $filename_in.\n";
open (OUT, "> ".$filename_out) || die "cannot open $filename_out.\n";

while (<FH>) {

    chomp;

    ($FID, $IID, $PID, $MID, $sex, $pheno) = split(' ');

    $PID = "0";
    $MID = "0";

    print OUT "$FID $IID $PID $MID $sex 0"."\n";
}

close (FH);
close (OUT);
