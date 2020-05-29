# Extract unrelated samples (chose by highest call rate)
# Katrina Galkina

#!usr/bin/perl

$numArgs = $#ARGV + 1;
my $filename_pheno = $ARGV[0];   #file contains list of common snps
my $filename_unrel = $ARGV[1];

open (PHENO, $filename_pheno) || die "cannot open $filename_pheno.\n";
open (UNREL, "> ".$filename_unrel) || die "cannot open $filename_unrel.\n";

%best_rels;
%best_iids;
$line_count = 0;

while (<PHENO>) {

    chomp;
    $line_count++;

#    ($FID, $IID, $sex, $callrate, $newFID) = split("\t");

    my @items = split(" ");

    if( $items[0] eq 'FID') {
	next;
    }

    my @families = $items[4];
    my $callrate = $items[3];
    my $iids = $items[1];

    foreach $person (@families) {
	$cur_callrate = $best_rels{$person};
	# Extract the individual with the highest call rate out of the family
	if ($cur_callrate eq '' || $callrate > $cur_callrate) {
	    $best_rels{$person} = $callrate;
	    $best_iids{$person} = $iids;
	}
    }
}    

while (($k, $v) = each %best_iids) {
    print UNREL "$k $v\n";
}

print "$line_count read\n";
   
close(PHENO);
close(UNREL);
