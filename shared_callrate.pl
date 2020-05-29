# Assessing quality of imputation solution
# Find snps common to mlmiss and imputed set
# Input mlinfo, lmiss files
# October, 2009
# Katrina Galkina

#!usr/bin/perl

$numArgs = $#ARGV + 1;
my $filename_info = $ARGV[0];
my $filename_lmiss = $ARGV[1];
my $filename_out = $ARGV[2];

open (INFO, $filename_info) || die "cannot open $filename_info.\n";
open (LMISS, $filename_lmiss) || die "cannot open $filename_lmiss.\n";
open (OUT, "> ".$filename_out) || die "cannot open $filename_out.\n";


%info_rsqs;

while (<INFO>) {

    chomp;

    ($snp, $al1, $al2, $freq, $maf, $qual, $rsq) = split("\t");
    
    if ( $snp eq 'SNP') {    #skip the header
	next;
    }

    $info_rsqs{$snp} = $rsq;
}

my $linecount = 0;
my $foundcount = 0;
my $chromosome;

while (<LMISS>) {

    chomp;
    $linecount++;

    ($chromosome, $snp, $nmiss, $ngeno, $fmiss) = split(" ");

    my $info_rsq = $info_rsqs{$snp};   #get rsq vals

    my $call_rate = 1 - $fmiss;

    if( $info_rsq eq '') {
	next;                 #snp not in list of rsq from info file
    }
    else {
	$foundcount++;
	print OUT $snp."\t".$fmiss."\t".$info_rsq."\t".$call_rate."\n";	
    }
	
}

print "Number of shared snps for chromosome $chromosome is $foundcount out of $linecount \n.";

close(INFO);
close(LMISS);
close(OUT);
