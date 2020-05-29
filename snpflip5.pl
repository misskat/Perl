## Finds SNP ids with minus strand (from affy 6 annotation csv file)
## Makes a list of RS Ids for snp flipping
## Required to make sure genotypes and hapmap samples are all in the same orientation
## For subsequent analysis (imputation, etc)

#!usr/bin/perl
use Text::CSV;

$numArgs = $#ARGV + 1;
my $filename_in = $ARGV[0];
my $filename_out = $ARGV[1];

open( CSV, $filename_in ) || die "cannot open $filename_in.\n";
open (OUT, "> ".$filename_out) || die "cannot open $filename_out.\n";

my $csv = Text::CSV->new();
my %ids;
my @uniqueIds;

while (<CSV>) {
    if ( $_ =~ m/^\#/ ) {
	next;
    }

    if ( $csv->parse($_) ) {
	my @columns = $csv->fields();

	#find minus strands and ambiguous strands
	if ( $columns[5] eq '-' ) {#-- $columns[5] eq '---') {
	    $ids{$columns[2]} = ' ';
	}
	
    }
    else {
	my $err = $csv->error_input;
	print "Failed to parse line: $err";
    }
}

#while ( ($k,$v) = each %ids ) {
#    print "$k => $v\n";
#}

@uniqueIds = keys(%ids);
foreach (@uniqueIds) {
    print OUT "$_\n";
}


close(CSV);
close (OUT);
