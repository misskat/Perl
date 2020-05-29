# Linear regression analysis
# Find the corresponding FIDs to IIDs
# Katrina Galkina

#!usr/bin/perl

$numArgs = $#ARGV + 1;
my $filename_fam = $ARGV[0];
my $filename_cag = $ARGV[1];
my $filename_out = $ARGV[2];

open (FAM, $filename_fam) || die "cannot open $filename_fam.\n";
open (CAG, $filename_cag) || die "cannot open $filename_cag.\n";
open (OUT, "> ".$filename_out) || die "cannot open $filename_out.\n";

%fams;
while (<FAM>) {

    chomp;
    $linecount++;

    ($FID, $IID, $pid, $mid, $sex, $pheno) = split(" ");

    $fams{$IID} = $FID;

}

# BOLZANO_HDCAG_PETER.txt
while (<CAG>) {

    chomp;

    ($IID, $cag1, $cag2) = split ("\t");

    my $FID = $fams{$IID};

    print OUT "$FID\t$IID\t$cag1\t$cag2\n"

}

close(FAM);
close(CAG);
close(OUT);
