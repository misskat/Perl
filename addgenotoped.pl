#!usr/bin/perl

$numArgs = $#ARGV + 1;
my $filename_geno = $ARGV[0];
my $filename_fam = $ARGV[1];
my $filename_out = $ARGV[2];

open (GENO, $filename_geno) || die "cannot open $filename_geno.\n";
open (FAM, $filename_fam) || die "cannot open $filename_fam.\n";
open (OUT, "> ".$filename_out) || die "cannot open $filename_out.\n";

%genotype;

#hd_final.snp
while (<GENO>) {

    chomp;

    ($IID) = split(" ");

    $genotype{$IID} = substr($_,length($IID)+1);

    $genotype{$IID} =~ s/\t/ /g;
 
}

#plink file
while (<FAM>) {

    chomp;

    ($FID, $IID, $PID, $MID, $sex, $pheno) = split(" ");

    if( $genotype{$IID} ne '') {
	print OUT "$FID\t$IID\t$PID\t$MID\t$sex\t$pheno\t$genotype{$IID}\n";
    }

}

close(GENO);
close(FAM);
close(OUT);
