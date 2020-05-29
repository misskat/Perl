#Counts phenotype types for case control analysis

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


    if ($pheno == 1) {
        $count1++;
    }

    if ($pheno == 2) {
        $count2++;
    }

}

close(FAM);

print "Phenos == 1 => $count1 , phenos == 2 => $count2 , missing phenos => $countmiss\n";
