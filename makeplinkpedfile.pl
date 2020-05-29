#Linkage/Merlin format -> plink

#!usr/bin/perl

$numArgs = $#ARGV + 1;
my $filename_ped = $ARGV[0];
my $filename_snp = $ARGV[1];
my $filename_out = $ARGV[2];

open (PED, $filename_ped) || die "cannot open $filename_ped.\n";
open (SNP, $filename_snp) || die "cannot open $filename_snp.\n";
open (OUT, "> ".$filename_out) || die "cannot open $filename_out.\n";

%fam;
%mother;
%father;
%gen;

#Bolzano file (missing genotypes)
while (<PED>) {

chomp;

($FID, $IID, $PID, $MID, $sex) = split("\t");

$fam{$IID} = $FID;
$mother{$IID} = $MID;
$father{$IID} = $PID;
$gen{$IID} = $sex;

}

#Bolzano file (containing genotypes)
while (<SNP>) {

chomp;

my @olditems = split(" ");
my $len = @olditems;
my @geno = @olditems[1..$len-1];

my $iid = $olditems[0];
my $fid = $fam{$iid};
my $pid = $father{$iid};
my $mid = $mother{$iid};
my $sex = $gen{$iid};

#beagle format
print OUT "$fid $iid $pid $mid $sex -9 @geno\n";

#print OUT "$fid $iid $pid $mid $sex 0\n";    
}

close(PED);
close(SNP);
close(OUT);
