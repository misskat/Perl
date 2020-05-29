# Katrina Galkina, June 2011

#!/usr/bin/perl -w

$numArgs = $#ARGV + 1;
my $phenofile = $ARGV[0];
my $famfile = $ARGV[1];
my $new = $ARGV[2];

open (PHENO, $phenofile) or die "cannot open file $phenofile\n";
open (FAM, $famfile) or die "cannot open file $famfile\n";
open (NEW, "> ".$new) or die "cannot open file $new\n";

my %map;
my %gender;

while (<PHENO>) {

    chomp;

# cov_age.txt
# ($FID, $IID, $pheno) = split(" ");

# CIDR_4_affected_age_newID.fam
    ($FID, $IID, $PID, $MID, $sex, $pheno) = split(" ");

    $map{$IID} = $pheno; 
    $gender{$IID} = $sex;

}

while (<FAM>) {
	
    chomp;

#pd_imputed_affecteds_newID
    ($FID, $IID, $PID, $MID, $sex, $pheno) = split(" ");

    my $newPheno = $map{$IID};
    my $newSex = $gender{$IID};

# Preserve order of imputed data
    print NEW "$FID $IID $PID $MID $newSex $newPheno\n";

}

close (PHENO);    
close (FAM);
close (NEW);
