#!/usr/bin/perl -w
###########################################################################
#
# Format the RFmix local ancestry calls for inferring parental ancestries
# with ANCESTOR
#
# 
# USAGE: perl ancestor_step1.pl IBS_YRI_CV.sample IBS_YRI_CV.snp_locations rfmix.Viterbi.txt 
##########################################################################
use strict;

my $sample = "$ARGV[0]";
my $locations = "$ARGV[1]";
my $viterbi = "$ARGV[2]";

my $chr;
if ($viterbi =~ m/chr(.*)\.rfmix/){
	$chr = $1;
} else {
	print "error: could not parse chromosome from $viterbi\n";
	exit;
}

my @sam; #sample order
my @cM; #snp locations (cM) in order
my %indivs; # hash with one key per individual
open (SAM, "$sample") or die "file not found: $!\n";
while(<SAM>){
	chomp();
	my $line = $_;
	push (@sam, $line);
	$indivs{$line} = [];
}
close(SAM);
my $samcount = scalar(@sam);
print "Collecting info for $samcount individuals\n";

open (LOC, "$locations") or die "file not found: $!\n";
while(<LOC>){
	chomp();
	my $line = $_;
	push (@cM, $line);
}
close(LOC);

#Now parse the haplotypes
open (VIT, "$viterbi") or die "file not found: $!\n";
my $snp = 0;
while(<VIT>){
	chomp();
	my $line = $_;
	my @fields = split /\s+/, $line;
	my $length = scalar(@fields);
	my $loc = "$cM[$snp]";

	for (my $i = 0; $i < ($length-2); $i+=2){
		my $name = "$sam[$i/2]";
		my $state1 = "$fields[$i]";
		my $state2 = "$fields[$i+1]";
		my $new1;
		my $new2;
		if ($state1 =~ m/1/){
			$new1 = 0;		
		} elsif ($state1 =~ m/2/){
			$new1 = 1;
		} else {
			print "warning: unable to parse state $state1\n";
			next;
		}
		if ($state2 =~ m/1/){
			$new2 = 0;		
		} elsif ($state2 =~ m/2/){
			$new2 = 1;
		} else {
			print "warning: unable to parse state $state2\n";
			next;
		}

		my @save = ($new1,$new2,$loc);	
		#add an array for this position
		if (exists $indivs{$name}){
			push (@{$indivs{$name}}, [@save] );
		} else {
			print "couldn't find label for $name\n";
		}
		#print "$name\t$loc\t$state1\t$state2\n";
	}
	$snp++;
}	
close(VIT);

foreach my $ind (keys %indivs){
	my $output = "ancestor-parse-step1-chr$chr"."-indiv"."$ind".".txt";
	open (OUT, ">$output") or die "unable to open: $!\n";
	my @all = @{$indivs{$ind}};
	foreach my $entry (@all){
		print OUT "$chr\t";
		print OUT "@{$entry}\n";
	}
	close (OUT);
}
