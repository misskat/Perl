# Assessing quality of imputation solution
# Compare error rates (.erate file) for snps that are in
# both imputed snps and genotyped set (commontoN.txt)
# October, 2009
# Katrina Galkina

#!usr/bin/perl

$numArgs = $#ARGV + 1;
my $filename_snp = $ARGV[0];   #file contains list of common snps
my $filename_erate = $ARGV[1];

open (SNP, $filename_snp) || die "cannot open $filename_snp.\n";
open (ERATE, $filename_erate) || die "cannot open $filename_erate.\n";

@common_snps = <SNP>;
chomp (@common_snps);

my $line_count = 0;
my $common_count = 0;
my $count_0_5 = 0;
my $count_5_10 = 0;
my $count_10plus = 0;
my $max_rate = 0;
my $min_rate = 1;

while (<ERATE>) {

    chomp;
    $line_count++;

    ($snp, $avgrate, $lastrate) = split(" ");

    if( $snp eq 'Marker') {
	next;
    }

    my $is_common = 0;
    foreach $common_snp (@common_snps) {

	if( $common_snp eq $snp) {
	    $is_common = 1;
	    $common_count++;
	    last;
	}
    }

    # skip record if snps are not shared
    if ($is_common == 0) {
	next;
    }

# Find max rate and min rate


    if ($avgrate > $max_rate) {
	$max_rate = $avgrate;
    }
    
    if ($avgrate < $min_rate) {
	$min_rate = $avgrate;
    }

#Find error rate ranges
    if( $avgrate < 0.05) {
	$count_0_5++;
    }
    else {
	if( $avgrate < 0.1) {
	    $count_5_10++;
	}
	else {
	    $count_10plus++;
	}
    }
}
   
print "$count_0_5 snps had an error rate between 0% and 5%, $count_5_10 snps had an error rate between 5% and 10%, $count_10plus snps had an error rate above 10% \n";
print "Maximum error rate is $max_rate and minimum error rate is $min_rate for $common_count snps out of $line_count total. \n";

close(SNP);
close(ERATE);
