#Combines all the score columns to make matrix of disease/trait predispositions for an individual
#Gives the score column a new name corresponding to the .profile file
#Katrina Galkina

#!usr/bin/perl 

$numArgs = $#ARGV + 1;
my $filename_out = $ARGV[0];

#Change directory to necessary one
#$dirname = "HAPMAP3/hapmap_profiles";

$dirname = "0_HAPMAP_LOAD/hapmap2_profiling/hapmap2_april_profiles";

#$dirname = "0_HAPMAP_LOAD/PD_scoring_rsq/profiles";

#$dirname = "0_HAPMAP_LOAD/newHD/HD_scoring_forcompletion/profiles";


opendir (DIR, $dirname) || die "cannot open directory $dirname.\n";

@thefiles = readdir(DIR);

open (OUT, "> ".$filename_out) || die "cannot open $filename_out.\n";
closedir (DIR);

my %scores = ();

foreach $file (@thefiles){

    unless ( ($file eq ".") || ($file eq "..") ) {

	open (FH, $dirname."/".$file) || die "cannot open $dirname/$file.\n";
     
	while (<FH>) {

	    chomp;

	    ($fid, $iid, $pheno, $cnt, $cnt2, $score) = split (" ");

	    if ($fid eq "FID") {
		next;
	    }

	    $scores{$iid}{$file} = $score;
	}
	close (FH);
    }
}

print OUT "iid\t";
foreach $file (@thefiles){
    unless ( ($file eq ".") || ($file eq "..") ) {
	print OUT "$file\t";
    }
} 
print OUT "\n";

for my $k1 ( sort keys %scores ) {
    print OUT $k1."\t"; #individuals
    foreach $file (@thefiles){
	unless ( ($file eq ".") || ($file eq "..") ) {
	    print OUT $scores{$k1}{$file}."\t";
	}
    } 
    print OUT "\n";
}
close (OUT);
