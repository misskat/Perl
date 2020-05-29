#plink raw format -> ent

#!usr/bin/perl

$numArgs = $#ARGV + 1;
my $filename_raw = $ARGV[0];
my $filename_ent = $ARGV[1];

open (RAW, $filename_raw) || die "cannot open $filename_raw.\n";
open (ENT, "> ".$filename_ent) || die "cannot open $filename_ent.\n";

# Number of individuals and snps
print ENT "1184 539\n";

%fam;
%mother;
%father;
%gen;

#plink file
while (<RAW>) {

chomp;

($FID, $IID, $PID, $MID, $sex, $geno) = split(" ");

if ($FID eq "FID") {
    next;
}

if( $sex == 1) {
    $gender eq "M";
}

if( $sex == 2) {
    $gender eq "F";
}

print ENT "$IID $gender $PID $MID $geno\n";

}

close(RAW);
close(ENT);
