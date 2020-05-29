# Duplicate monoallelic genotype to make biallelic
# for R-plugin
# March, 2010

#!usr/bin/perl

$numArgs = $#ARGV + 1;
my $filename_geno = $ARGV[0];
my $filename_out = $ARGV[1];

open (GENO, $filename_geno) || die "cannot open $filename_geno.\n";
open (OUT, "> ".$filename_out) || die "cannot open $filename_out.\n";

while (<GENO>) {

    chomp;

#    ($fid, $iid, $pid, $mid, $sex, $pheno, $geno) = split(" ");

    my @items = split(" ");
    
    if ($items[0] eq 'FID'){
	next;
    }

    my $len = @items;
    my @info = @items[0..5];

    print OUT "@info ";

    for (my $i=6; $i<$len; $i++){
	print OUT "$items[$i] $items[$i] ";   #make biallelic
    }
	print OUT "\n";
}


close (GENO);
close (OUT);
