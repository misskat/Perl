##Bad file naming
## Changes pheno, mother and father id's to 0

#!usr/bin/perl 

$numArgs = $#ARGV + 1;
my $filename_in = $ARGV[0];
my $filename_out = $ARGV[1];


open (FH, $filename_in) || die "cannot open $filename_in.\n";
open (OUT, "> ".$filename_out) || die "cannot open $filename_out.\n";

while (<FH>) {

    chomp;

#($FID, $IID, $PID, $MID, $sex, $pheno, $geno) = split(' ', $oneline);

    my @olditems = split(' '); 
    my $len = @olditems;

    my @items = @olditems[0..5,6..$len-1];

    $items[2] = "0";
    $items[3] = "0";
    $items[5] = "0";

    print OUT "@items\n";


}

close (FH);
close (OUT);


## Converts mlgeno file to ped by
## Removing ML_GENO column
## Appending ped info
## Takes mlgeno file

#!usr/bin/perl

$numArgs = $#ARGV + 1;
my $filename_in = $ARGV[0];
my $filename_out = $ARGV[1];


open (FH, $filename_in) || die "cannot open $filename_in.\n";
open (OUT, "> ".$filename_out) || die "cannot open $filename_out.\n";

while (<FH>) {

    chomp;

    my @olditems = split(' ');
    my $len = @olditems;
    my @items = @olditems[2..$len-1];

    my @ID = split("->",$olditems[0]);

    print OUT ">$ID[0]\n $ID[1] 0 0 2 -9 @items\n";

}

close (FH);
close (OUT);
