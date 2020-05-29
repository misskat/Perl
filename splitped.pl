#Opens ped file and splits it into num samples

#!usr/bin/perl

$numArgs = $#ARGV + 1;
my $filename_prefix = $ARGV[0];
my $num = $ARGV[1];

open (PED, $filename_prefix.".ped") || die "cannot open $filename_prefix".".ped\n";

my $filecount = 1;
my $linecount = 0;
my $filename;

while (<PED>) {

    if( ($linecount % $num) == 0) {
	
	print "working on file $filecount...\n";
	close (OUT);
	$filename = $filename_prefix."_".$filecount.".ped";
	open (OUT, "> ".$filename) || die "cannot open output file $filename.\n";
	$filecount++;
    }
    print OUT $_;
    $linecount++;
}

close (OUT);
