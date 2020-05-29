#!usr/bin/perl 

$numArgs = $#ARGV + 1;
my $filename_in = $ARGV[0];
my $filename_out = $ARGV[1];


open (FH, $filename_in) || die "cannot open $filename_in.\n";
open (OUT, "> ".$filename_out) || die "cannot open $filename_out.\n";


my %filenames;

while (<FH>) {

    chomp;

#($FID, $IID, $PID, $MID, $sex, $pheno, $geno) = split(' ', $oneline);

    my @olditems = split(' '); 
    my $len = @olditems;

    my @items = @olditems[0..4,6..$len-1];

    $items[2] = "0";
    $items[3] = "0";

    print OUT "@items\n";

   # print $items[0]."+".$items[1]."+".$items[2]."+".$items[3]."+".$items[4]."+".$items[5]."+\n";

#print $len;
#print "$FID\n";

#$PID = "0";
#$MID = "0";

#    print OUT $FID." ".$IID." ".$PID." ".$MID." ".$sex." ".$geno."\n";
}

close (FH);
close (OUT);
