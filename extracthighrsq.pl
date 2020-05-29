# Extracts only snps with rsq above certain cutoff
# cutoff of 0.3 is reference, 0.8 is test
# Input: mlinfo file
# Needed for subsequent linear regression analysis

#!/usr/bin/perl

$numArgs = $#ARGV + 1;
my $filename_in = $ARGV[0];
my $filename_out = $ARGV[1];


open (FH, $filename_in) || die "cannot open $filename_in.\n";
open (OUT, "> ".$filename_out) || die "cannot open $filename_out.\n";


while (<FH>) {

    chomp;


    ($SNP, $Al1, $Al2, $Freq1, $MAF, $Quality, $Rsq) = split('\t');


    if( $Rsq >= 0.8){

	print OUT $SNP."\n";

   }

}

close (FH);
close (OUT);

