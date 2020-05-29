#!/usr/bin/perl -w

$numArgs = $#ARGV + 1;
my $file = $ARGV[0];
my $new = $ARGV[1];


open (FILE, $file) or die "cannot open file $file\n";
open (NEW, "> ".$new) or die "cannot open file $new\n";

while (<FILE>) {

    chomp;

    ($snp, $allele, $or) = split(" ");

    $lor = log($or);

    print NEW "$snp $allele $lor\n";

}
    
close (FILE);
close (NEW);
