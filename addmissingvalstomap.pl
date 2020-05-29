#Adds a (-) sign to every 5th element of the list
#Optionally, output the list of snps set to missing
#Input: map file
#For checking imputation correctness

#!/usr/bin/perl

$numArgs = $#ARGV + 1;
my $filename_in = $ARGV[0];
my $filename_out = $ARGV[1];


open (FH, $filename_in) || die "cannot open $filename_in.\n";
open (OUT, "> ".$filename_out) || die "cannot open $filename_out.\n";


while (<FH>) {

    chomp;

    my @items = split('\t');


    if (0 == $. % 5) { 
	$items[2] = -($items[2]);
	print OUT $items[1]."\n";        #show only missing snps
    }

    print OUT $items[0]."\t".$items[1]."\t".$items[2]."\n";

}

close (FH);
close (OUT);

