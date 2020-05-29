#!usr/bin/perl

# Comparing 2 results of MACH imputation
# Calculate similarity between 2 mlgeno files
# June, 2010
# Katrina Galkina

$numArgs = $#ARGV + 1;
my $filename_geno1 = $ARGV[0];
my $filename_geno2 = $ARGV[1];

open (GENO1, $filename_geno1) || die "cannot open $filename_geno1.\n";
open (GENO2, $filename_geno2) || die "cannot open $filename_geno2.\n";

$l1;
$l2;

$linecounter = 0;
$samecounter = 0;
$totalsamenucls = 0;
$totalmismatchnucls = 0;

while (($l1 = <GENO1>) && ($l2 = <GENO2>)) {

    $linecounter++;

#    print "*".$linecounter;

    chomp($l1);
    chomp($l2);

    $l1 =~ s/\// /g;
    $l2 =~ s/\// /g;

    my @items1 = split(' ', $l1);
    my @items2 = split(' ', $l2);

    my @ID1 = split("->", $items1[0]);
    my @ID2 = split("->", $items2[0]);

    
    if( $ID1[1] ne $ID2[1]) {
        print "Individuals do not match! ID1 = $ID1[1], ID2 = $ID2[1].\n";
        next;
    }

    my $len1 = @items1;
    my $len2 = @items2;

    if( $len1 != $len2) {
	print "String lengths do not match!\n";
	next;
    }

# Len contains FID, IID, ML_GENO
    my $geno_length = $len1 - 2;
    
    my $countersame = 0;

    for ($i = 2; $i < $len1; $i++) {
	if( $items1[$i] eq $items2[$i] ) {
	    $countersame++;
	}
    }

    $totalsamenucls += $countersame;
    $totalmismatchnucls += ($geno_length - $countersame);

#    print $counter."*";

    $counter_percent = $countersame/$geno_length * 100;
    
    if( $counter_percent != 100) {
	print "fam id = $ID1[0], $ID2[0] and IID = $ID1[1], $ID2[1] matching only $counter_percent percent, different by ".($geno_length - $countersame)." out of $geno_length nucleotides.\n";
    }
    else
    {
	$samecounter++;
    }
}

close(GENO1);
close(GENO2);

print "Total individuals tested: $linecounter\n";
print "Total individuals with identical nucleotides: $samecounter\n";
print "Total nucleotide pairs compared: ".($totalsamenucls+$totalmismatchnucls)."\n";
print "Total mismatched nucleotide pairs: $totalmismatchnucls\n";
