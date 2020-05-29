# Extracts snp col and distance
# Input: Hapmap legend file
# Output: file in map format
#!/usr/bin/perl

$numArgs = $#ARGV + 1;
my $filename_in = $ARGV[0];
my $filename_out = $ARGV[1];


open (FH, $filename_in) || die "cannot open $filename_in.\n";
open (OUT, "> ".$filename_out) || die "cannot open $filename_out.\n";


while (<FH>) {

    chomp;

    ($rs, $pos, $a1, $a2) = split("\t");

    if( $rs eq "rs") {
	next;
    }


    print OUT "16"."\t".$rs."\t"."0"."\t".$pos."\n";


}

close (FH);
close (OUT);

