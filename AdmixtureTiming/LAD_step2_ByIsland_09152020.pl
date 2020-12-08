#!/usr/bin/perl -w
#######################################################################
# In 10Mb windows, get LAD 
# 
# USAGE: perl LAD_step2 dir/
# ####################################################################
use strict;

my @samples = <"$ARGV[0]"/CalculateLADstep1_ByIsland_chr*>;
my @windir = <"$ARGV[0]"/CalculateLAD_WINDOWS_chr*>;

#first, collect windows
foreach my $winset (@windir){
	my $chrom;
	if ($winset =~ /CalculateLAD_WINDOWS_chr(.*).txt/){
		$chrom = $1;
	} else {
		print "warning: difficulty parsing window file name $winset\n";
		next;
	}

	my @islands;
	for my $check (@samples){
		if ($check =~ /.*chr$chrom\_.*/){
			push (@islands, $check);
		}
	}
	print "For chromosome $chrom:\nChecking files @islands\n";

	my %windows;
	#grab the windows we want to parse
	open (WIN, $winset) or die "file not found: $!\n";
	while (<WIN>){
		chomp();
		my $line = $_;
		my @allFields = split /\s+/, $line;
		my $start = "$allFields[1]";
		my $end1 = "$allFields[2]";
		my $end2 = "$allFields[3]";
		my $end3 = "$allFields[4]";
		my @ends = ($end1, $end2, $end3);
		$windows{$start} = [@ends];
	}
	close(WIN);
	#Now find and parse the corresponding map file
	my %positions = ();
	my $mapcount = 0;
	my $map = "$ARGV[0]"."/IBS_GWD_CV_chr$chrom".".map";
	print "corresponding maps file: $map\n";
	open (MAP, "$map") or die "file not found: $!\n";
	while(<MAP>){
		chomp();
		my $line = $_;
		my @allFields = split /\s+/, $line;
		my $coord = "$allFields[0]";
		$positions{$mapcount} = $coord;
		$mapcount++;
	}	
	close(MAP);
		
	#now go through each island, checking LAD at the windows we just collected
	for my $island (@islands){
		my $islname;
		if ($island =~ /chr$chrom\_(\w+)_09162020/){
			$islname = $1;
		} else {
			print "warning: trouble parsing name $island\n";
			next;
		}

		my $count = 0;
		my %positionsdata;
		open (SM, "$island") or die "file not found: $!\n";
		while(<SM>){
			chomp();
			my $line = $_;
			my @all = split /\s+/, $line;
			my $thisCoord = $positions{$count};
			$positionsdata{$thisCoord} = [@all];
			$count++;	
		}
		close(SM);

		#now grab and output LAD for each window
		my $output = "CalculateLADstep2_ByIsland_chr$chrom"."_$islname"."_09162020".".txt";
		open (OUT, ">$output") or die "unable to open: $!\n";	
		#print OUT "START\tEND\t\tHAPS\tg1\tg2\tg11\tLAD\n";
		for my $winStart (keys %windows){
			my @winEnds = @{$windows{$winStart}};
			my @dataStart = @{$positionsdata{$winStart}};

			my $winCount = 1;
			for my $end (@winEnds){
				my @dataEnd = @{$positionsdata{$end}};
				my $length = scalar(@dataStart);
				#get the prop haps with ancestry 1 at position1, position2, and both
				my $p1count1 = 0;
				my $p2count1 = 0;
				my $bothcount1 = 0;
				my $indivs = 0;
				for (my $i = 0; $i < $length; $i++){
					my $p1 = "$dataStart[$i]";
					my $p2 = "$dataEnd[$i]";
					if (($p1 == 1) && ($p2 == 1)){
						$bothcount1++;
					} 
					if ($p1 == 1){
						$p1count1++;
					} 
					if ($p2 == 1){
						$p2count1++;
					} 
					$indivs++;				
				}
				my $p1prop = ($p1count1/$indivs);
				my $p2prop = ($p2count1/$indivs);
				my $bothprop = ($bothcount1/$indivs);
				my $lad = ($bothprop)-($p1prop*$p2prop);
				print OUT "$winStart\t$winCount\t$indivs\t$p1prop\t$p2prop\t$bothprop\t$lad\n";
				$winCount++;
			}	
		}
		close(OUT);		
	}
}
