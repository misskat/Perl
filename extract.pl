#!usr/bin/perl 
 
$numArgs = $#ARGV + 1;
my $filename_in = $ARGV[0];
#my $filename_out = $ARGV[1];

open( FH, $filename_in ) || die "cannot open $filename_in.\n";
#open (OUT, "> ".$filename_out) || die "cannot open $filename_out.\n";

my $line;

#print subset of lines in file (such as BIM)

for my $i (1..200) {
    $line = <FH>;
    print $line;
}
