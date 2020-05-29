# Extracts snp and p-val column for
# Regional association plot
# Input: linear assoc file

#!/usr/bin/perl

$numArgs = $#ARGV + 1;
my $filename_in = $ARGV[0];
my $filename_out = $ARGV[1];


open (FH, $filename_in) || die "cannot open $filename_in.\n";
open (OUT, "> ".$filename_out) || die "cannot open $filename_out.\n";


while (<FH>) {

    chomp;


#    ($SNP, $Al1, $Al2, $Freq1, $MAF, $Quality, $Rsq) = split('\t');

    ($chr, $rs, $bp, $a1, $test, $nmiss, $beta, $stat, $p) = split("\t");

    if( $chr eq "CHR") {
	next;
    }

    if( $chr eq '8') {
	print OUT "$chr\t$rs\t$bp\t$p\n";
    }

}

close (FH);
close (OUT);

