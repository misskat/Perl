# Assessing quality of imputation solution
# Find snps common to mlinfo imputed set
# and bim genotyped set for subsequent comparison
# of quality and genotype
# September, 2009
# Katrina Galkina

#!usr/bin/perl

$numArgs = $#ARGV + 1;
my $filename_bim = $ARGV[0];
my $filename_info = $ARGV[1];
my $filename_out = $ARGV[2];

open (BIM, $filename_bim) || die "cannot open $filename_bim.\n";
open (INFO, $filename_info) || die "cannot open $filename_info.\n";
open (OUT, "> ".$filename_out) || die "cannot open $filename_out.\n";


@bim_snps;

while (<BIM>) {

    chomp;

    ($chromosome, $snp, $dist, $bp_pos, $a1, $a2) = split("\t");

    push( @bim_snps, $snp);

}

my $linecount = 0;
my $foundcount = 0;
my $chromosome;

while (<INFO>) {

    chomp;
    $linecount++;

#    ($chromosome, $snp, $dist, $bp_pos, $a1, $a2) = split("\t");

    ($snp, $bp_pos, $a1, $a2) = split("\t");

    foreach $bim_snp (@bim_snps) {
	if ($snp eq $bim_snp) {
	    $foundcount++;
	    print OUT "$snp\t$bp_pos\n";	
	    last;
	}
	
    }

}

print "Number of shared snps for is $foundcount out of $linecount \n.";


close(INFO);
close(BIM);
close(OUT);
