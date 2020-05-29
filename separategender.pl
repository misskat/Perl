# Makes separate male and female fam files
# for linear regression analysis
# Input: FAM file
# October, 2009
# Katrina Galkina

#!usr/bin/perl

$numArgs = $#ARGV + 1;

my $filename_fam = $ARGV[0];
my $filename_male = $ARGV[1];
my $filename_female = $ARGV[2];

open (FAM, $filename_fam) || die "cannot open $filename_fam.\n";
open (MALE, "> ".$filename_male) || die "cannot open $filename_male.\n";
open (FEMALE, "> ".$filename_female) || die "cannot open $filename_male.\n";


while (<FAM>) {        #actually ped

    chomp;

    ($fid, $iid, $pid, $mid, $gender, $pheno, $geno) = split(" ");

    my @olditems = split(" ");
    my $len = @olditems;
    my @geno = @olditems[6..$len-1];

    if ($gender == 1) {
	print MALE "$fid $iid $pid $mid $gender $pheno @geno\n";
    }
    if ($gender == 2) {
	print FEMALE "$fid $iid $pid $mid $gender $pheno @geno\n";        
    }

}

#previously
#while (<FAM>) {

 #   chomp;

  #  ($FID, $IID, $PID, $MID, $sex, $pheno) = split(" ");

   # if ($sex == 1) {
	#print MALE "$FID $IID $PID $MID $sex $pheno\n";
    #}
    #if ($sex == 2) {
	#print FEMALE "$FID $IID $PID $MID $sex $pheno\n";
    #}
    
#}

close(FAM);
close(MALE);
close(FEMALE);
