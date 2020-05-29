# Phasing Bolzano dataset
# Reconstruct a tfam (fam) file from
# Beagle output (IDs only that where parents are duplicated)
# Katrina Galkina
# June, 2010

#!usr/bin/perl

$numArgs = $#ARGV + 1;

my $filename_eur = $ARGV[0];
my $filename_fam = $ARGV[1];
my $filename_out = $ARGV[2];

open (EUR, $filename_eur) || die "cannot open $filename_eur.\n";
open (FAM, $filename_fam) || die "cannot open $filename_fam.\n";
open (OUT, "> ".$filename_out) || die "cannot open $filename_out.\n";

# allbztrios100_IDs.bgl.phased.txt
@iids = <EUR>;
chomp (@iids);

$linecount = 0;
$commoncount = 0;

# bzfamtypes_FamsMINDME.fam
while (<FAM>) {

    chomp;

    $linecount++;

    ($FID, $IID, $pid, $mid, $sex, $pheno) = split(" ");

    foreach $iid (@iids){
	if ($iid eq $IID) {
	    $commoncount++;
	    print OUT "$FID $iid $pid $mid $sex $pheno\n";
	    last;
	}

    }

}

print "$commoncount common samples out of $linecount total\n";

close(FAM);
close(EUR);
close(OUT);
