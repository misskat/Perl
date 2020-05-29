# Sets phenotype to 1 or 2 (late onset vs early)
# For snp profiling analysis on disease state
# Katrina Galkina, June 2010

#!/usr/bin/perl -w

$numArgs = $#ARGV + 1;
my $phenofile = $ARGV[0];
my $famfile = $ARGV[1];
my $newpheno = $ARGV[2];

open (PHENO, $phenofile) or die "cannot open file $phenofile\n";
open (FAM, $famfile) or die "cannot open file $famfile\n";
open (NEWPHENO, "> ".$newpheno) or die "cannot open file $newpheno\n";

my %phenotypes;

while (<PHENO>) {

    chomp;

    ($FID, $IID, $sex, $cr, $newfam, $mds1, $mds2, $mds3, $mds4, $cag1, $cag2, $onset, $lnonset, $res, $stdres) = split("\t");

    if( $FID eq 'FID') {  #skip the header
	next;
    }

    $phenotypes{$IID} = $stdres; 

}

while (<FAM>) {
	
    chomp;
    ($FID, $IID, $PID, $MID, $sex, $pheno) = split(" ");

    $pheno = $phenotypes{$IID};

#pheno = 1 if residual positive, 2 if residual negative, -9 if residual -9 (missing)

    if( $pheno == -9 ) {
        $pheno = '-9';
    }
    else {
	if( $pheno > 0 ) {
	    $pheno = '1';
	}
	else {
	    if( $pheno < 0) {
		$pheno = '2';
	    }
	}
    }

    print NEWPHENO "$FID $IID $PID $MID $sex $pheno\n";

}
    
close (FAM);
close (PHENO);
close (NEWPHENO);
