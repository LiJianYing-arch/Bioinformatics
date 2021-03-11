#!usr/bin/perl 
open FL,"<55.txt";
@a=<FL>;
print "@a\n";
close FL;
open OUT,">>out.txt";
foreach $line (@a) {
chomp $line;
$line=uc $line;
@b=split "\t", $line;
print "@b\n";
}