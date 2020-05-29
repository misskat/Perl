# Add original MID, PID and gender values
# to imputed ped files using FAM file
# Input: original FAM and PED (previously mlgeno) files
# October, 2009
# Katrina Galkina

#!usr/bin/perl

$numArgs = $#ARGV + 1;

my $filename_fam = $ARGV[0];
my $filename_ped = $ARGV[1];
my $filename_out = $ARGV[2];

open (FAM, $filename_fam) || die "cannot open $filename_fam.\n";
open (PED, $filename_ped) || die "cannot open $filename_ped.\n";
open (OUT, "> ".$filename_out) || die "cannot open $filename_out.\n";

%mother;
%father;
%gen;

while (<FAM>) {

    chomp;

    ($FID, $IID, $PID, $MID, $sex, $pheno) = split(" ");

    $mother{$IID} = $MID;
    $father{$IID} = $PID;
    $gen{$IID} = $sex;

}

while (<PED>) {

    ($fid, $iid, $pid, $mid, $gender, $pheno, $geno) = split(" ");

    my @olditems = split(" ");
    my $len = @olditems;
    my @geno = @olditems[6..$len-1];


    my $cor_pid = $father{$iid};
    my $cor_mid = $mother{$iid};
    my $cor_gen = $gen{$iid};

    print OUT "$fid $iid $cor_pid $cor_mid $cor_gen $pheno @geno\n";

}

#print "$commoncount common snps out of $linecount total\n";

close(FAM);
close(PED);
close(OUT);
