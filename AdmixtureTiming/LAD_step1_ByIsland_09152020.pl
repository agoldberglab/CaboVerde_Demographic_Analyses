#!/usr/bin/perl -w
#######################################################################
# In 10Mb windows, get LAD and recombination rate
# 
# USAGE: perl LAD_step1 dir/ Pop-IID-Key-4grps.txt keep_CV.inds
# ####################################################################
use strict;

my @samples = <"$ARGV[0]"/*.2.Viterbi.txt>;
my $popkey = "$ARGV[1]";
my $keep = "$ARGV[2]";

my @order;
my %pops;
open (KEY, $popkey) or die "file not found: $!\n";
my $header = <KEY>;
while (<KEY>){
	chomp();
	my $line = $_;
	my @info = split /\s+/, $line;
	my $id = "$info[0]";
	my $island = "$info[1]";
	$pops{$id}=$island;
}
close(KEY);
open (KEEP, $keep) or die "file not found: $!\n";
while (<KEEP>){
	chomp();
	my $line = $_;
	if (exists $pops{$line}){
		my $isl = $pops{$line};
		push (@order, $isl);
	} else {
		print "unable to find island for $line\n";
	}
}
close(KEEP);

foreach my $sample (@samples){
	my $chrom;
	if ($sample =~ /IBS_GWD_CV_chr(.*).rfmix/){
		$chrom = $1;
		print "working on chr $chrom, file: $sample\n";
	} else {
		print "trouble parsing name for $sample\n";
		exit;
	}	

	my $outputSan = "CalculateLADstep1_ByIsland_chr$chrom"."_Santiago_09162020".".txt";
	my $outputFogo = "CalculateLADstep1_ByIsland_chr$chrom"."_Fogo_09162020".".txt";
	my $outputNW = "CalculateLADstep1_ByIsland_chr$chrom"."_NW_09162020".".txt";
	my $outputBV = "CalculateLADstep1_ByIsland_chr$chrom"."_BV_09162020".".txt";
	open (OUTS, ">$outputSan") or die "unable to open: $!\n";	
	open (OUTF, ">$outputFogo") or die "unable to open: $!\n";	
	open (OUTN, ">$outputNW") or die "unable to open: $!\n";	
	open (OUTB, ">$outputBV") or die "unable to open: $!\n";	

	#Windows:
	my $outWin = "CalculateLAD_WINDOWS_chr"."$chrom".".txt";
	open (OUTW, ">$outWin") or die "unable to open: $!\n";	
	
	#Now find and parse the corresponding map file
	my $lastcoord = 0;
	my %positions = ();
	my $map = "$ARGV[0]"."/IBS_GWD_CV_chr$chrom".".map";
	print "corresponding maps file: $map\n";
	open (MAP, "$map") or die "file not found: $!\n";
	my $snpcount = 0;
	while(<MAP>){
		chomp();
		my $line = $_;
		my @allFields = split /\s+/, $line;
		my $coord = "$allFields[0]";
		$lastcoord = $coord;
		$positions{$coord} = $coord;
	}	
	close(MAP);
	#now walk through this chromosome in windows of 10MB, overlapping by 1MB
	my $finalStart = ($lastcoord - 10000000);
	for (my $i = 1; $i <= $finalStart; $i+=9000000){
		my $winStart = $i;
		my $winEnd = ($i+10000000);
		# walk up from the start and walk back from the end until this coord exists in %positions
		my $realStart;
		my $realEnd;
		do {
			if (exists $positions{$winStart}){
				$realStart = $winStart;
			} else {
				$winStart++;
			}
		} until((exists $positions{$winStart}) || ($winStart >= $winEnd));
		#now winStart is defined

		#get a 1mb end, a 5mb end, and a 10mb end
		do {
			if (exists $positions{$winEnd}){
				$realEnd = $winEnd;
			} else {
				$winEnd--;
			}
		} until((exists $positions{$winEnd}) || ($winEnd <= $i));
		if (($winStart >= $winEnd ) || ($winEnd <= $i)){
			next; #skip this window
		}
		my $end5 = ($i+5000000);
		do {
			if (exists $positions{$end5}){
				$realEnd = $end5;
			} else {
				$end5--;
			}
		} until((exists $positions{$end5}) || ($end5 <= $i));
		if (($winStart >= $end5 ) || ($end5 <= $i)){
			next; #skip this window
		}
		my $end1 = ($i+1000000);
		do {
			if (exists $positions{$end1}){
				$realEnd = $end1;
			} else {
				$end1--;
			}
		} until((exists $positions{$end1}) || ($end1 <= $i));
		if (($winStart >= $end1 ) || ($end1 <= $i)){
			next; #skip this window
		}

		#now both start and end are defined, write to file:
		print OUTW "$chrom\t$winStart\t$end1\t$end5\t$winEnd\n";
	}
	
	open (SM, "$sample") or die "file not found: $!\n";
	while(<SM>){
		chomp();
		my $line = $_;
		my @all = split /\s+/, $line;
		#if the --use-reference-panels-in-EM option was used, the reference haplotypes
		#   are all in the file at the beginning (214 GWD, then 214 IBS, then 1,126 CV)
		splice(@all, 0, 428);	
		my $haps = scalar(@all);
		my $islands = scalar(@order);
		if (($haps != 1126)|| ($islands != 563)){
			print "warning: $haps haplotypes and $islands island entries at $chrom, $line\n";
		}

		for (my $i = 0; $i < $islands; $i++){
			#i is the index of the island in @order
			#i*2 is the 1st hap and (i*2)+1 is the second hap in @all		
			my $I = "$order[$i]";
			my $hap1 = "$all[$i*2]";
			my $hap2 = "$all[($i*2)+1]";
			if($I eq "Santiago"){
				print OUTS "$hap1\t$hap2\t";
			}elsif($I eq "NWcluster"){
				print OUTN "$hap1\t$hap2\t";
			}elsif($I eq "BoaVista"){
				print OUTB "$hap1\t$hap2\t";
			}elsif($I eq "Fogo"){
				print OUTF "$hap1\t$hap2\t";
			}else{
				print "not sure about $I\n";
			}
		}
		print OUTS "\n";
		print OUTF "\n";
		print OUTN "\n";
		print OUTB "\n";
	}	
	close(SM);
	close (OUTW);
	close (OUTS);
	close (OUTF);
	close (OUTB);
	close (OUTN);
}
