# Extract child ID from
# .fmendel file which has
# pid and mid and num of children
# Example: perl findchild.pl mendeltest.fmendel hd_final.ped newbzfamstrios.ped

#!usr/bin/perl

$numArgs = $#ARGV + 1;
my $filename_fm = $ARGV[0];
my $filename_ped = $ARGV[1];
my $filename_out = $ARGV[2];

open (FM, $filename_fm) || die "cannot open $filename_fm.\n";
open (PED, $filename_ped) || die "cannot open $filename_ped.\n";
open (OUT, "> ".$filename_out) || die "cannot open $filename_out.\n";

$triocount = 0;
$famcount = 1;
%child_count;
%familyID;
%father;
%mother;

#.fmendel
while (<FM>) {

    chomp;

    ($FID, $PAT, $MAT, $CH) = split(" ");

    $triocount++;

    if( $FID eq "FID") {
	next;
    }

    $child_count{$PAT."&".$MAT} = $CH;
    
    #reconstitute family ID if FID = '1' 
    my $newfam;
    if( $FID eq "1") {
	$newfam = "Trio".$famcount;
	$famcount++;
    }
    #remember good family ID
    else  {
	$newfam = $FID;
    }
    $familyID{$PAT."&".$MAT} = $newfam;
    #remember each parent to preserve their genotypes
    $father{$PAT} = $newfam;
    $mother{$MAT} = $newfam;
}

$linecount = 0;
$foundcount = 0;

#hd_final.ped
while (<PED>) {

    chomp;    

    ($FID, $IID, $PID, $MID, $sex) = split("\t");

    my $parents = $PID."&".$MID;

    #found a kid!
    if( $child_count{$parents} ne ''){
	$foundcount++;
	#decrease child count for this family
	$child_count{$parents} = $child_count{$parents} - 1;
	print OUT "$familyID{$parents}\t$IID\t$PID\t$MID\t$sex\t-9\n";
    }
}    

while( my ($k, $v) = each %father ) {
    print OUT "$v\t$k"."-F"."\t0\t0\t1\t-9\n";
}

while( my ($k, $v) = each %mother ) {
    print OUT "$v\t$k"."-M"."\t0\t0\t2\t-9\n";
}

while( my ($k, $v) = each %child_count ) {
    if( $v != 0) {
	print "Incorrect number of children $v found for $k\n";
    }
}

print "$foundcount trios found out of $triocount\n";

close(PED);
close(FM);
close(OUT);
