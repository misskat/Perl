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
    $_ =~ s/\// /g;
    
    my @olditems = split(' '); 
    my $len = @olditems;
    
    my @geno = @olditems[2..$len-1];

    my @ID = split("->",$olditems[0]);

    print OUT "$ID[0] $ID[1] 0 0 2 -9 @geno\n";

}

close (FH);
close (OUT);
