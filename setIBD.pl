# Set estimated IBD < 0.125 to 0 (result from plink --genome)
# Helps ensure the creation of a sparse kinship matrix for LME analysis

#!usr/bin/perl

$numArgs = $#ARGV + 1;
my $filename_genome = $ARGV[0];  
my $filename_kin = $ARGV[1];

open (GENOME, $filename_genome) || die "cannot open $filename_genome.\n";
open (KIN, "> ".$filename_kin) || die "cannot open $filename_kin.\n";

my $ibdcounter = 0;

print KIN "FID1 IID1 FID2 IID2 RT EZ Z0 Z1 Z2 PI_HAT2 PHE DST PPC RATIO\n";

while (<GENOME>) {

    chomp;

    my @items = split(" ");

    if( $items[0] eq 'FID1') {
        next;
    }

# Set estimated IBD < 0.125 to 0
    if( $items[9] < 0.125) {
        $items[9] == 0;
	$ibdcounter++;
    }

    print KIN "@items\n";

}

print "$ibdcounter values changed!\n";

close (GENOME);
close (KIN);
