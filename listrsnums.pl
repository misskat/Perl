## Chops chromosome into SNPS of 1000
## Takes .BIM file (of each chromosome)

#!usr/bin/perl -w

$numArgs = $#ARGV + 1;
my $filename_in = $ARGV[0];
my $filename_out = $ARGV[1];
my $filename_mach = $ARGV[2];

open (BIM, $filename_in) || die "cannot open $filename_in.\n";
open (PLINK, "> ".$filename_out) || die "cannot open $filename_out.\n";
open (MACH, "> ".$filename_mach) || die "cannot open $filename_mach.\n";

my $linecounter = 0;
my $filecounter = 0;
my $rs_from;
my $line_from;
my $last_rs;
my @items;

my $chromosome = "chr22";


while (<BIM>) {

    $linecounter++;
    @items = split('\t');
#    $last_rs = $items[1];

    if( ($linecounter % 1000) == 1){
	$rs_from = $items[1];
	$line_from = $linecounter;
    }

    if( ($linecounter % 1000) == 0){
        $filecounter++;
	print PLINK "./plink --bfile $chromosome"."new --from $rs_from --to $items[1] --recode-whap --out $chromosome"."sub$filecounter\n"; 
#($line_from to $linecounter)\n";
    }


#    if( $items[0] == '0'){
#	next;
#    }

#    print @items;

#    print "$j: $items[1]\n";

}
$filecounter++;

print PLINK  "./plink --bfile $chromosome"."new --from $rs_from --to $items[1] --recode-whap --out $chromosome"."sub$filecounter\n";

close (FH);
close (PLINK);

