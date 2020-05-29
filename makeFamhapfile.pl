#plink ped format -> famhap

#!usr/bin/perl

$numArgs = $#ARGV + 1;
my $filename_ped = $ARGV[0];
my $filename_fh = $ARGV[1];

open (PED, $filename_ped) || die "cannot open $filename_ped.\n";
open (FH, "> ".$filename_fh) || die "cannot open $filename_fh.\n";

# Number of individuals and snps
print FH "FID IID MO FA SEX AFF ";

for ($i = 1; $i <= 539; $i++){
    print FH "M".$i."_A "."M".$i."_B ";
}

print FH "\n";

while (<PED>) {

chomp;

($FID, $IID, $PID, $MID, $sex, $pheno, $geno) = split(" ");

my @olditems = split(" ");
my $len = @olditems;
my @geno = @olditems[6..$len-1];


print FH "$IID $FID $MID $PID $sex 1 @geno\n";

}

close(PED);
close(FH);
