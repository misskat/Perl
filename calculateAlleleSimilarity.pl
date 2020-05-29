# Assessing quality of imputation solution
# Calculate similarity between genotyped snps (map or bim file)
# and imputed snps (mlinfo file) based on allele similarity
# Looks at shared snps only
# Input: mlinfo, bim, out file
# September, 2009
# Katrina Galkina

#!usr/bin/perl

$numArgs = $#ARGV + 1;
my $filename_info = $ARGV[0];
my $filename_bim = $ARGV[1];
my $filename_out = $ARGV[2];
#my $filename_nf = $ARGV[3];

open (INFO, $filename_info) || die "cannot open $filename_info.\n";
open (BIM, $filename_bim) || die "cannot open $filename_bim.\n";
open (OUT, "> ".$filename_out) || die "cannot open $filename_out.\n";
#open (NF, "> ".$filename_nf) || die "cannot open $filename_ng.\n";

%info_alleles;

while (<INFO>) {

    chomp;

    ($snp, $al1, $al2, $freq, $maf, $qual, $rsq) = split("\t");
    
    if ( $snp eq 'SNP') {    #skip the header
	next;
    }

    $info_alleles{$snp} = $al1.$al2;
}

$line_count = 0;
$count_100 = 0;
$count_50 = 0;
$count_0 = 0;

while (<BIM>) {

    chomp;
    $line_count++;
    ($chr, $snp, $dist, $bp_pos, $a1, $a2) = split("\t");

    $ref_alleles = $info_alleles{$snp};

    my $hit = 0;

    my $r1 = substr($ref_alleles, 0, 1);  #first symbol
    my $r2 = substr($ref_alleles, 1, 1);  #2nd symbol


#    if( $ref_alleles ne "") {
#	print $r1.$r2." ";
#    }
#    else {
#	print NF "Match not found for $snp\n";
#    }
    

    if ($a1 eq $r1) {
	$hit++;
	$r1 = "y";
    }
    else {
	if( $a1 eq $r2) {
	    $hit++;
	    $r2 = "y";
	}
    }

    if ($a2 eq $r1) {
        $hit++;
        $r1 = "x";
    }
    else {
        if( $a2 eq $r2) {
            $hit++;
            $r2 = "x";
        }
    }

    if( $hit == 0) {
	print OUT "$snp $a1 $a2 $r1 $r2 \n";
	$count_0++;
    }
    if( $hit == 1) {

	$count_50++;
    }
    if( $hit == 2) {
        $count_100++;
        }
}

my $total = ($count_0/$count_100)*100;
print "0% similar: $count_0, 50% similar: $count_50, 100% similar: $count_100; total: $total %\n";


close(INFO);
close(BIM);
close(OUT);
