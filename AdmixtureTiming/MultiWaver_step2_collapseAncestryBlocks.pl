#!/usr/bin/perl -w
###########################################################################
# Author: Katharine Korunes
# Step2 in formatting the RFmix local ancestry calls for Multiwaver
# 
# USAGE: perl Multiwaver_step2.pl dir/ updateIDs-all.txt
##########################################################################
use strict;

my $dir = "$ARGV[0]";
my @longfiles = <"$ARGV[0]"/multiwaver-parse-step1-*>;

my %santiago;
my %boavista;
my %nwcluster;
my %fogo;
my $IDs = "$ARGV[1]";
open (ID, "$IDs") or die "unable to open: $!\n";
while (<ID>){
	chomp();
	my $line = $_;
	my @fields = split /\s+/, $line;
	my $num = "$fields[1]";
	my $pop = "$fields[2]";
	if ($pop eq "Santiago"){
		$santiago{$num} = "Santiago";
	}elsif ($pop eq "BoaVista"){
		$boavista{$num} = "BoaVista";
	}elsif ($pop eq "NWcluster"){
		$nwcluster{$num} = "NWcluster";
	}elsif ($pop eq "Fogo"){
		$fogo{$num} = "Fogo";
	}elsif (($pop eq "GWD") || ($pop eq "IBS")){
		#print "skipping ref pop $pop\n";
		next;
	}else{
		print "skipping unrecognized pop $pop\n";
	}

}
close(ID);
	
my $outSan = "MultiwaverInp_Santiago.txt";
my $outBoa = "MultiwaverInp_BoaVista.txt";
my $outNw = "MultiwaverInp_NWcluster.txt";
my $outFogo = "MultiwaverInp_Fogo.txt";
open (OUTSAN, ">$outSan") or die "unable to open: $!\n";
open (OUTBOA, ">$outBoa") or die "unable to open: $!\n";
open (OUTNW, ">$outNw") or die "unable to open: $!\n";
open (OUTFOGO, ">$outFogo") or die "unable to open: $!\n";

my $sanCount = 0;
my $boaCount = 0;
my $nwCount = 0;
my $fogoCount = 0;
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

	my $grp;
	if (exists $santiago{$id}){
		$sanCount++;
		$grp = "san";
	}elsif (exists $boavista{$id}){
		$boaCount++;
		$grp = "boa";
	}elsif (exists $nwcluster{$id}){
		$nwCount++;
		$grp = "nw";
	}elsif (exists $fogo{$id}){
		$fogoCount++;
		$grp = "fogo";
	} else {
		next;
	}

	#Now parse the haplotypes down to ancestry blocks
	open (IN, "$input") or die "file not found: $!\n";

	#parse the 2 haplotypes
	for (my $hap = 1; $hap <= 2; $hap++){
		#print "parsining haplotype $hap of individual $id chromosome $chr\n";
		my $start = 0;
		my $laststate;
		my $count = 0;
		my $lastplace;
 		while(<IN>){
			chomp();
			my $line = $_;
			my @fields = split /\s+/, $line;
			my $state = "$fields[$hap]";
			my $place = "$fields[3]";
			#if it's the first one, set the states:
			if ($count == 0){
				$laststate = $state;
				$lastplace = $place;
			}
			if ( $state == $laststate ){
				$lastplace = $place;
				$laststate = $state;	
				$count++;
				next;
			} else {
				my $pos1 = ($start/100);
				my $pos2 = ($lastplace/100);
				my $anc;
				if ($state == 0){
					$anc = 1;
				} elsif ($state == 1){
					$anc = 2;
				} else {
					print "WARNING unrecognized ancestry\n";
				}

				if ($grp eq "san"){
					print OUTSAN "$pos1\t$pos2\t$anc\n";
				}elsif ($grp eq "boa"){
					print OUTBOA "$pos1\t$pos2\t$anc\n";
				}elsif ($grp eq "nw"){
					print OUTNW "$pos1\t$pos2\t$anc\n";
				}elsif ($grp eq "fogo"){
					print OUTFOGO "$pos1\t$pos2\t$anc\n";
				}else{
					print "warning unsure of pop for $id\n";
				}
				$lastplace = $place;
				$laststate = $state;
				$start = $place;
				$count++;
			}
		}
	}	
	close(IN);
}
close (OUTSAN);
close (OUTBOA);
close (OUTNW);
close (OUTFOGO);
print "found $sanCount chrom-individual combinations for Santiago\n";
print "found $boaCount chrom-individual combinations for BoaVista\n";
print "found $nwCount chrom-individual combinations for NWcluster\n";
print "found $fogoCount chrom-individual combinations for Fogo\n";
