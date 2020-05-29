## Finds SNP ids with minus strand 
## Makes a list of RS Ids for snp flipping

#!usr/bin/perl 

$numArgs = $#ARGV + 1;
my $filename_in = $ARGV[0];
my $filename_out = $ARGV[1];


open (FH, $filename_in) || die "cannot open $filename_in.\n";
open (OUT, "> ".$filename_out) || die "cannot open $filename_out.\n";

while (<FH>) {

    chomp;

    ($ProbeID, $AffyID, $RSID , $Chrom, $pos, $strand, $ChrX, $Cytoband, $Fland, $A, $B, $Gene, $Map, $Msat, $Frag, $Freq, $HZ, $num, $hap, $versus, $copynum, $probe, $psa, $final, $minor, $mafreq, $gc ) = split('\t');


    if( $ProbeID =~ /^\#/ or $ProbeID eq 'Probe Set ID') {
	next;
    }

#    print "Probe id: $ProbeID.\n";
#    print "Affy id: $AffyID.\n";
  
    if( $strand eq '-' || $strand eq '---') {
	print OUT $RSID."\n";
    }
}

close (FH);
close (OUT);
