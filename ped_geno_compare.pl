# Assessing quality of imputation solution
# Calculate similarity between genotyped snps (ped file)
# and imputed snps (mlgeno file) based on genotype similarity
# October, 2009
# Katrina Galkina

#!usr/bin/perl

$numArgs = $#ARGV + 1;
my $filename_ped1 = $ARGV[0];
my $filename_ped2 = $ARGV[1];
#my $filename_out = $ARGV[2];

open (PED1, $filename_ped1) || die "cannot open $filename_ped1.\n";
open (PED2, $filename_ped2) || die "cannot open $filename_ped2.\n";

%genotypes1;

while (<PED1>) {

    chomp;

    ($fid, $iid, $mid, $pid, $gender, $pheno ) = split(" ");
    
    $genotypes1{$iid} = $_;
}


my $missing_calls = 0;
my $smaller_total;

while (<PED2>) {

    chomp;
    $line_count++;
    
    ($fid, $iid, $mid, $pid, $gender, $pheno) = split(" ");
    
    my $genotype1 = $genotypes1{$iid};

    my @g1 = split(" ", $genotype1);
    my @g2 = split(" ", $_);

    my $count_similar = 0;
    my $total_chars1 = @g1;
    my $total_chars2 = @g2;    
    $smaller_total = $total_chars1;
    my $larger_total = $total_chars2;
    my $total_for_percentage = $larger_total;


    if( $smaller_total > $total_chars2) {
	$smaller_total = $total_chars2;
	$larger_total = $total_chars1;
    }

    for( my $i = 6; $i < $smaller_total; $i++) {
	if ($g1[$i] eq $g2[$i]) {
	    $count_similar++;
	}
	else {
	    #If genotype contains 0 decrease larger total (do not compare with 0)
	    if ($g1[$i] eq "0") {    
		$total_for_percentage--;
		$missing_calls++;
	    }
	}
    }

    my $percent_similar = $count_similar*100/$total_for_percentage;

    print "IID = $iid, percent similar = $percent_similar \n";
    print "similar count $count_similar out of $smaller_total : $larger_total; missing calls = $missing_calls \n";

}

print "$missing_calls calls out of $smaller_total are missing\n";

close(PED1);
close(PED2);

