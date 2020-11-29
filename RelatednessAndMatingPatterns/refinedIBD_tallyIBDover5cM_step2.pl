#!/usr/bin/perl -w
#######################################################################
# Parse the RefinedIBD output (all chromosomes concatenated) to get total length and total
# number of IBD between each pair of individuals.
#
# USAGE: perl refinedIBD_tallyIBD_step2.pl Inp
######################################################################
use strict;

my $inp = "$ARGV[0]";
my $out = "$inp"."_over5cM_byIndiv.txt";

#arrays in %inds: (number, length )
my %inds;
open (IN, "$inp") or die "file not found: $!\n";
my $pairs=0;
while(<IN>){
	chomp();
	my $line = $_;
	my @allFields = split /\s+/, $line;
	my $id1 = "$allFields[0]";
	my $id2 = "$allFields[2]";
	my $thisLen = "$allFields[8]";
	if ($thisLen <= 5){
		next;
	}

	my $combo = "$id1".",$id2";		
	my $alt = "$id2".",$id1";
	if ( (exists $inds{$combo}) || (exists $inds{$alt}) )  {
		my @retrieved = ();
		if (exists $inds{$combo}) {
			@retrieved = @{$inds{$combo}};
		} elsif (exists $inds{$alt}){
			@retrieved = @{$inds{$alt}};
		}else{
			print "error: couldn't find $combo\n";
			exit;
		}	
		my $count = "$retrieved[0]";
		my $length = "$retrieved[1]";
		$count++;	
		my $newLength = ($thisLen+$length);
		#print "found $count,$length for ids $combo\n";
		my @update=($count,$newLength);
		if (exists $inds{$combo}) {
			$inds{$combo} = \@update;
		} elsif (exists $inds{$alt}){
			$inds{$alt} = \@update;
		}
	}else{
		$pairs++;
		my $start = 1;
		my @new = ($start,$thisLen);
		$inds{$combo}=\@new;
	}
}	
close(IN);
print "processed $pairs pairs\n";

open (OUT, ">$out") or die "unable to open: $!\n"; 
print OUT "ID1\tID2\tCount\tLength\n";
foreach my $key (keys %inds){
	my @ids = split /,/, $key;
	my @totals = @{$inds{$key}};
	my $ind1 = "$ids[0]";
	my $ind2 = "$ids[1]";
	my $save1 = "$totals[0]";
	my $save2 = "$totals[1]";
	print OUT "$ind1\t$ind2\t$save1\t$save2\n";
}
close(OUT);

