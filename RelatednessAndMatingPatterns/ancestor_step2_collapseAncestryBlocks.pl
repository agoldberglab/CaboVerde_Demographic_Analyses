#!/usr/bin/perl -w
###########################################################################
#
# Step2 in formatting the RFmix local ancestry calls for inferring parental ancestries
# with ANCESTOR
#
# 
# USAGE: perl ancestor_step1.pl dir/
##########################################################################
use strict;

my $dir = "$ARGV[0]";
my @longfiles = <"$ARGV[0]"/ancestor-parse-step1-*>;

foreach my $input (@longfiles){
	my $chr;
	my $id;
	if ($input =~ m/chr(.*)-indiv(.*)\.txt/){
		$chr = $1;
		$id = $2;
	} else {
		print "error: could not parse name of $input\n";
		exit;
	}
	my $output = "ancestor-parse-step2-chr$chr"."-indiv"."$id".".txt";
	open (OUT, ">$output") or die "unable to open: $!\n";

	#Now parse the haplotypes down to ancestry blocks
	open (IN, "$input") or die "file not found: $!\n";
	my $start = 0;
	my $laststate1;
	my $laststate2;
	my $count = 0;
	my $lastplace;
	while(<IN>){
		chomp();
		my $line = $_;
		my @fields = split /\s+/, $line;
		my $state1 = "$fields[1]";
		my $state2 = "$fields[2]";
		my $place = "$fields[3]";
		#if it's the first one, set the states:
		if ($count == 0){
			$laststate1 = $state1;
			$laststate2 = $state2;
			$lastplace = $place;
		}
		if (($state1 == $laststate1) && ($state2 == $laststate2)){
			$lastplace = $place;
			$laststate1 = $state1;
			$laststate2 = $state2;
			$count++;
			next;
		} else {
			my $len = (($lastplace - $start)/100);
			print OUT "$chr\t$laststate1\t$laststate2\t$len\n";
			$lastplace = $place;
			$laststate1 = $state1;
			$laststate2 = $state2;
			$start = $place;
			$count++;
		}
	}	
	close(IN);
	close (OUT);
}
