#!/usr/bin/perl -w
#######################################################################
# Author: Katharine Korunes
# Parse the Garlic output (*.roh.bed) to get total length and total
# number of ROH by class for each individual.
#
# USAGE: perl GarlicStep4_parse-garlic.pl Inp
######################################################################
use strict;

my $garlic = "$ARGV[0]";
my $out = "$garlic"."_byIndiv.txt";

#arrays in %inds: (num A, num B, num C, length A, length B, length C)
my %inds; #keep track of the # of runs and the total length for each indiv
my $countInd = 0;
open (GAR, "$garlic") or die "file not found: $!\n";
my $id = "null";
while(<GAR>){
	chomp();
	my $line = $_;
	if($line =~ /track.*Ind:\s+(.*)\s+Pop.*/){
		$id = $1;
		print "$id\n";
	}else{
		my @allFields = split /\s+/, $line;
		my $class = "$allFields[3]";
		my $len = "$allFields[4]";
		if (!exists $inds{$id}){
			$countInd++;
			my @new = (0,0,0,0,0,0);
			$inds{$id}=\@new;
		}
		my @retrieved = @{$inds{$id}};
		my $aCount = "$retrieved[0]";
		my $bCount = "$retrieved[1]";
		my $cCount = "$retrieved[2]";
		my $aLen = "$retrieved[3]";
		my $bLen = "$retrieved[4]";
		my $cLen = "$retrieved[5]";
		if ($class eq "A"){
			$aCount++;
			$aLen = ($aLen + $len);
		}elsif($class eq "B"){
			$bCount++;
			$bLen = ($bLen + $len);
		}elsif($class eq "C"){
			$cCount++;
			$cLen = ($cLen + $len);
		}else{
			print "ERROR: unsure how to parse $line\n";
		}
		my @update=($aCount,$bCount,$cCount,$aLen,$bLen,$cLen);
		$inds{$id} = \@update;
	}
}	
close(GAR);
print "Found ROH runs from $countInd individuals\n";

open (OUT, ">$out") or die "unable to open: $!\n"; 
print OUT "INDIV\tAcount\tBcount\tCcount\tAlength\tBlength\tClength\n";
foreach my $key (keys %inds){
	my @roh = @{$inds{$key}};
	print OUT "$key\t";
	print OUT "@roh\n";
}
close(OUT);
