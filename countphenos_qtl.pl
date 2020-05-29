#Counts the types of phenotypes in a fam file for QTL analysis

#!/usr/bin/perl

my $famfile = $ARGV[0];

open (FAM, $famfile) or die "cannot open file $famfile\n";

$count1 = 0;
$count2 = 0;
$countmiss = 0;

while (<FAM>) {

    chomp;
    ($FID, $IID, $PID, $MID, $sex, $pheno) = split(' ');

    if ($pheno == -9) {
	$countmiss++;
    }
    else
    {
	if ($pheno < 0 ) {
	    $count1++;
	}
	
	if ($pheno > 0) {
	    $count2++;
	}
    }
}

close(FAM);

print "Phenos < 0 => $count1 , phenos > 0  => $count2 , missing phenos => $countmiss\n";
