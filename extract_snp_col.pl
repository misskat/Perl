# Extracts snp col 
# Input: mlinfo file or Hapmap legend file

#!/usr/bin/perl

$numArgs = $#ARGV + 1;
my $filename_in = $ARGV[0];
my $filename_out = $ARGV[1];


open (FH, $filename_in) || die "cannot open $filename_in.\n";
open (OUT, "> ".$filename_out) || die "cannot open $filename_out.\n";


while (<FH>) {

    chomp;


#    ($SNP, $Al1, $Al2, $Freq1, $MAF, $Quality, $Rsq) = split('\t');

    ($rs, $pos, $a1, $a2) = split("\t");

    if( $rs eq "rs") {
	next;
    }


    print OUT $rs."\n";


}

close (FH);
close (OUT);

