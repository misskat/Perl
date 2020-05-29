# Find the corresponding FIDs to IIDs
# Katrina Galkina

#!usr/bin/perl

$numArgs = $#ARGV + 1;

my $filename_bz = $ARGV[0];
my $filename_fam = $ARGV[1];
my $filename_out = $ARGV[2];

open (BZ, $filename_bz) || die "cannot open $filename_bz.\n";
open (FAM, $filename_fam) || die "cannot open $filename_fam.\n";
open (OUT, "> ".$filename_out) || die "cannot open $filename_out.\n";


#BZiids.txt
@iids = <BZ>;
chomp (@iids);

$linecount = 0;
$commoncount = 0;

#hd_final.ped
while (<FAM>) {

    chomp;
    $linecount++;


    ($FID, $IID, $pid, $mid, $sex) = split(" ");

    foreach $iid (@iids){
	if ($iid eq $IID) {
	    $commoncount++;
	    print OUT "$FID\t$IID\n";
	    last;
	}
    }

}

print "$commoncount common snps out of $linecount total\n";

close(FAM);
close(BZ);
close(OUT);
