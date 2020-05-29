## Converts mlgeno file to ped by
## Removing ML_GENO column
## Appending ped info
## Takes mlgeno file

#!usr/bin/perl 

$numArgs = $#ARGV + 1;
my $filename_mlgeno = $ARGV[0];
my $filename_fam = $ARGV[1];
my $filename_ped = $ARGV[2];

open (MLGENO, $filename_mlgeno) || die "cannot open $filename_mlgeno.\n";
open (FAM, $filename_fam) || die "cannot open $filename_fam.\n";
open (OUT, "> ".$filename_ped) || die "cannot open $filename_ped.\n";

%phenotype;
%gender;

while (<FAM>) {

    chomp;

    ($FID, $IID, $PID, $MID, $sex, $pheno) = split(" ");

    $phenotype{$IID} = $pheno;
    $gender{$IID} = $sex;

}

while (<MLGENO>) {

    chomp;
#    ($fid, $iid, $pid, $mid, $gender, $pheno, $geno) = split(" ");

    $_ =~ s/\// /g;

    my @olditems = split(' ');
    my $len = @olditems;
    my @geno = @olditems[2..$len-1];

    my @ID = split("->",$olditems[0]);

    my $cor_fid = $ID[0];
    my $cor_iid = $ID[1];
  
    my $cor_gen = $gender{$cor_iid};
    my $cor_pheno = $phenotype{$cor_iid};

    print OUT "$cor_fid $cor_iid 0 0 $cor_gen $cor_pheno @geno\n";

}

close(FAM);
close(MLGENO);
close(OUT);
