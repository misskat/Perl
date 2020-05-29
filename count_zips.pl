#!/usr/bin/perl
#Count the number of unique zip codes in a file

#my $numArgs = $#ARGV + 1;
my $in = $ARGV[0];
my $out = $ARGV[1];

open (IN, $in) or die "cannot open $in\n";
open (OUT, "> ".$out) or die "cannot open $out\n";

my %uniquezips;
my $count;
my @items;

while (<IN>) {

chomp;


@items = split(",");

	if ($items[0] eq 'NACCID') {
		next;
	}


my $zip = $items[8];

$count = $uniquezips{$zip};

	if ($count ne '') {
		$uniquezips{$zip} = $count+1;
	}
	else {
		$uniquezips{$zip} = 1;
	}

}


print OUT "ZIP\tcount\n";


while (($key, $v) = each %uniquezips) {
	print OUT $key."\t".$v."\n";
}

close(IN);
close(OUT);