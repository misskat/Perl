# IBS/IBD clustering performance check:
# Parses .fam file and assigns individuals to clusters
# Looks through .genome file and makes a hash of PI_HATS, rewind file
# Looks through .genome file and merges families with PI_HAT > 0.2
# Then rewrites .fam file to contain newly assigned family ids
# Katrina Galkina - MGH - May 1, 2009


#!/usr/local/bin/perl -w
#use strict;

$numArgs = $#ARGV + 1;
my $famfile = $ARGV[0];
my $genomefile = $ARGV[1];
my $newfamfile = $ARGV[2];

open (FAM, $famfile) or die "cannot open file $famfile\n";
open (GENOME, $genomefile) or die "cannot open file $genomefile\n";
open (NEWFAM, "> ".$newfamfile) or die "cannot open file $newfamfile\n";


##### Part I: working with .fam file #####

my $i = 1;     #initialization of cluster. One person = 1 cluster.
my %clusters;


while (<FAM>) {

    chomp;
    ($FID, $IID, $PID, $MID, $sex, $pheno) = split(' ');
	
# Assign each individual to its own cluster
    $clusters{$IID} = $i++;
}

#while (($k, $v) = each %clusters) {
#    print "$k => $v\n";
#}

##### Part II: working with .genome file #####

my %pi_hats;

while (<GENOME>) {
    chomp;

    ($FID1, $IID1, $FID2, $IID2, $RT, $EZ, $Z0, $Z1, $Z2, $PI_HAT, $PHE, $DST, $PPC, $RATIO) = split(' ');

    if( $FID1 eq 'FID1') {       #skip the header
	next;
    } 

    $pi_hats{$IID1}{$IID2} = $PI_HAT;       #populate a hash of pi_hats for individuals

}

seek (GENOME, 0, 0);  #rewind file

##### Part III: working with .genome file #####

#my $ line_count = 0;
my $family_count = 0;


while (<GENOME>) {
#    $line_count++;
    chomp;
    ($FID1, $IID1, $FID2, $IID2, $RT, $EZ, $Z0, $Z1, $Z2, $PI_HAT, $PHE, $DST, $PPC, $RATIO) = split(' ');

    if( $FID1 eq 'FID1') {       #skip the header
	next;
    } 

### Look for families to be MERGED ###
    if( $clusters{$IID1} ne $clusters{$IID2} && $PI_HAT > 0.2) {
	$family_count++;          # The number of such cases counted
#	&merge_clusters($clusters{$IID1}, $clusters{$IID2});
        &merge_clusters_strict($clusters{$IID1}, $clusters{$IID2});
    }

}     #end of main loop

seek(FAM, 0, 0);       #rewind file

while (<FAM>) {

    chomp;
    ($FID, $IID, $PID, $MID, $sex, $pheno) = split(' ');


    print NEWFAM "PH_FAM_".$clusters{$IID}." ".$IID." ".$PID." ".$MID." ".$sex." ".$pheno."\n";

}

#&show_clusters( $PI_HAT);


close (NEWFAM);
close (GENOME);
close (FAM);


sub merge_clusters {

    my $A = $_[0];
    my $B = $_[1];

    if( $A  ne '' && $B ne '') {
	#print "Merging $A and $B because PI_HAT = $PI_HAT\n";

	while (($k, $v) = each %clusters) { 
	    if ($v == $A) {
		$clusters{$k} = $B;
	    }
	}
    }
}

# Merge clusters only if every pair of individuals in clusters to be merged has good pi_hat
sub merge_clusters_strict {

    my $A = $_[0];
    my $B = $_[1];

    my @A_people;
    my @B_people;

    while (($k, $v) = each %clusters) {
		if ($v == $A) {
	    	push(@A_people, $k);
		}
		if ($v == $B) {
	    	push(@B_people, $k);
		}
    }

    for( my $i=0; $i < @A_people; $i++) {
		for( my $j=0; $j < @B_people; $j++) {
	    	my $pi_hat = $pi_hats{$A_people[$i]}{$B_people[$j]};
	    	if( $pi_hat eq '') {
		    $pi_hat = $pi_hats{$B_people[$j]}{$A_people[$i]};
	    	}
	    	if( $pi_hat < 0.2) {
	    	#	print "Cannot merge $A and $B because $A_people[$i] and $B_people[$j] have $pi_hat.\n";
				return;
	    	}
		}
    }
	 
	 &merge_clusters($A, $B);

}

sub show_clusters {

    my $PI_HAT = $_[0];

#    print "_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_\n";

#    foreach my $param( keys %clusters) {
	#print "$param => $clusters{$param}, PI_HAT = $PI_HAT\n";
    #}

}
