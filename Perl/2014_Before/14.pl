#!/usr/local/bin/perl -w
use Bio::Trace::ABIF;
my $abif = Bio::Trace::ABIF->new();
my @arry=<*.ab1>;
for my $q(@arry){
$abif->open_abif("/data02/JianyinLi/format_transcript/non/$q");
open FL ,">$q.seq";
open FLS ,">$q.qual";
#print $abif->sample_name(),"\n";
my @quality_values=$abif->quality_values();
my $sequence = $abif->sequence();
print FLS "@quality_values\n";
print FL "$sequence\n";
close FL;
close FLS;
}
$abif->close_abif();
