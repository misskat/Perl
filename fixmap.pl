# add base pair position to map file
#!/usr/bin/perl

$numArgs = $#ARGV + 1;
my $filename_in = $ARGV[0];
my $filename_out = $ARGV[1];


open (FH, $filename_in) || die "cannot open $filename_in.\n";
open (OUT, "> ".$filename_out) || die "cannot open $filename_out.\n";

print OUT "CHROMOSOME\tMARKER\tPOSITION\n";

while (<FH>) {

    chomp;

    ($chr, $rs, $dis) = split("\t");

    if( $chr eq "CHROMOSOME") {
	next;
    }

    # 1 cM = 1,000,000 bp
    $pos = ($dis / 1000000);

#    print OUT "$chr\t$rs\t$dis\t$pos\n";
    print OUT "$chr\t$rs\t$pos\n";

}

close (FH);
close (OUT);

