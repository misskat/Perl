#Excludes X, Y and MT chromosomes

#!/usr/bin/perl

$numArgs = $#ARGV + 1;
my $filename_in = $ARGV[0];
my $filename_out = $ARGV[1];


open (FH, $filename_in) || die "cannot open $filename_in.\n";
open (OUT, "> ".$filename_out) || die "cannot open $filename_out.\n";

my @goodchrs = (1..23);

print OUT "CHR\tSNP\tUNADJ\tGC\tBONF\tHOLM\tSIDAK_SS\tSIDAK_SD\tFDR_BH\tFDR_BY\n";

while (<FH>) {

    chomp;

    ($chr, $rs, $unad, $gc, $test, $holm, $sid1, $sid2, $fdr1, $fdr2) = split(" ");

    if( $chr eq "CHR") {
	next;
    }

    my $goodchr = $goodchrs[$chr];

    if( $goodchr eq '') {
	next;
    }
    else {
	print OUT "$chr\t$rs\t$unad\t$gc\t$test\t$holm\t$sid1\t$sid2\t$fdr1\t$fdr2\n";
    }
}

close (FH);
close (OUT);

