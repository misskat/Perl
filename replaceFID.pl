# Katrina Galkina, June 2010

#!/usr/bin/perl -w

$numArgs = $#ARGV + 1;
my $phenofile = $ARGV[0];
my $famfile = $ARGV[1];
my $new = $ARGV[2];

open (PHENO, $phenofile) or die "cannot open file $phenofile\n";
open (FAM, $famfile) or die "cannot open file $famfile\n";
open (NEW, "> ".$new) or die "cannot open file $new\n";

my %map;

while (<PHENO>) {

    chomp;

    ($FID, $IID, $sex, $cr, $newfam, $mds1, $mds2, $mds3, $mds4, $cag1, $cag2, $onset, $lnonset, $res, $stdres) = split("\t");

    if( $FID eq 'FID') {  #skip the header
	next;
    }

    $map{$IID} = $newfam; 

}

while (<FAM>) {
	
    chomp;
    ($FID, $IID, $PID, $MID, $sex, $pheno) = split(" ");

    my $newFID = $map{$IID};

    print NEW "$newFID $IID $PID $MID $sex $pheno\n";

}
    
close (FAM);
close (PHENO);
close (NEW);
