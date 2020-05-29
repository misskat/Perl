#!/usr/bin/perl

$numArgs = $#ARGV + 1;
my $filename_in = $ARGV[0];
#my $filename_out = $ARGV[1];


open (FH, $filename_in) || die "cannot open $filename_in.\n";
#open (OUT, "> ".$filename_out) || die "cannot open $filename_out.\n";

my $rsq1count = 0;
my $linecount = 0;

while (<FH>) {

    $linecount++;
    chomp;

#    my @items; # = split('\t');

    ($SNP, $Al1, $Al2, $Freq1, $MAF, $Quality, $Rsq) = split("\t"); #, @items);

#    if( $items[6] >= 0.3){
	if( $Rsq >= 0.95) {
	    $rsq1count++;
	}
    #print OUT $items[0]."\t".$items[6]."\n";


}

print "rsq >= 0.95: $rsq1count out of $linecount snps\n";

close (FH);
#close (OUT);

