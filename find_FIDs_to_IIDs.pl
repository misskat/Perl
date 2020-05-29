# Linear regression analysis
# Find the corresponding FIDs to IIDs
# Katrina Galkina

#!usr/bin/perl

$numArgs = $#ARGV + 1;

my $filename_eur = $ARGV[0];
my $filename_fam = $ARGV[1];
my $filename_out = $ARGV[2];

open (EUR, $filename_eur) || die "cannot open $filename_eur.\n";
open (FAM, $filename_fam) || die "cannot open $filename_fam.\n";
open (OUT, "> ".$filename_out) || die "cannot open $filename_out.\n";


@iids = <EUR>;
chomp (@iids);

$linecount = 0;
$commoncount = 0;

while (<FAM>) {

    chomp;
    $linecount++;


    ($FID, $IID, $pid, $mid, $sex, $pheno) = split(" ");

    foreach $iid (@iids){
	if ($iid eq $IID) {
	    $commoncount++;
	    print OUT "$FID\t$IID\n";
	    last;
	}

    }


}

print "$commoncount common samples out of $linecount total\n";

close(FAM);
close(EUR);
close(OUT);
