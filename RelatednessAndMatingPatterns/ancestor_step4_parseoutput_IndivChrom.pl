#!/usr/bin/perl -w
#######################################################################
# Parse the ancestor output 
# 
# USAGE: perl ancestor_step4.pl /DirWithAncestor.outs
use strict;

my @INPUT = <"$ARGV[0]"/ancestor-parse-step2-chr*.txt.out>;
my $output = "parsedsummary_indivchromosomes";
open (OUT, ">$output") or die "unable to open: $!\n";
print OUT "ID\tCHR\tPARENT1\tPARENT2\tAVG\n";

foreach my $in (@INPUT){
	open (IN, "$in") or die "file not found: $!\n";
	while(<IN>){
		chomp();
		my $line = $_;
		if ($line =~ /ancestor-parse-step2-chr(.*)-indiv(.*)\.txt/){
			my $chr = $1;
			my $id = $2;
			my $blank = (<IN>);
			my $p1 = (<IN>);
			my $p2 = (<IN>);
			my @allp1 = split /\s+/, $p1;
			my @allp2 = split /\s+/, $p2;
			if (($p1 =~ /^Parent/) && ($p2 =~ /^Parent/)){
				my $parent1 = "$allp1[4]";
				my $parent2 = "$allp2[4]";
				if (($parent1 =~ /\[/) && ($parent2 =~ /\[/)){
					$parent1 =~ s/\[//g;
					$parent2 =~ s/\[//g;
					my $avg = ($parent1 + $parent2)/2;
					print OUT "$id\t$chr\t$parent1\t$parent2\t$avg\n";
				} else {
					print "unexpected $parent1 or $parent2 format\n";
				}
			} else {
				print "looks like something is wrong with $in\n";
			}							
		} else {
			next;
		}
	}	
	close(IN);
}
close(OUT);
