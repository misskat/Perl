#plink raw format -> ent

#!usr/bin/perl

$numArgs = $#ARGV + 1;
my $filename_raw = $ARGV[0];
my $filename_ent = $ARGV[1];

open (RAW, $filename_raw) || die "cannot open $filename_raw.\n";
open (ENT, "> ".$filename_ent) || die "cannot open $filename_ent.\n";

# Number of individuals and snps
print ENT "1184 539\n";

my $gender;
#plink file
while (<RAW>) {

chomp;

($FID, $IID, $PID, $MID, $sex, $pheno, $geno) = split(" ");

if ($FID eq "FID") {
    next;
}

my @olditems = split(" ");
my $len = @olditems;
my @geno = @olditems[6..$len-1];


if( $sex == 1) {
    $sex = "M";
}

if( $sex == 2) {
    $sex = "F";
}

print ENT "$IID $sex $PID $MID ".join("",@geno)."\n";

}

close(RAW);
close(ENT);
