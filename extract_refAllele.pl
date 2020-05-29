# Extracts snp col and major allele A1
# Want mlinfo & bim alleles to be same order
# Input: mlinfo file
# Output: snp and A1 columns

#!/usr/bin/perl

$numArgs = $#ARGV + 1;
my $filename_in = $ARGV[0];
my $filename_out = $ARGV[1];


open (FH, $filename_in) || die "cannot open $filename_in.\n";
open (OUT, "> ".$filename_out) || die "cannot open $filename_out.\n";


while (<FH>) {

    chomp;

    ($snp, $a1, $a2, $freq1, $maf, $qual, $rsq) = split("\t");

    if( $snp eq "SNP") {
	next;
    }


    print OUT "$snp"."\t"."$a1"."\n";


}

close (FH);
close (OUT);

