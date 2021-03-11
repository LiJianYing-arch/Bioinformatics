#!usr/bin/perl 
open (FL,"518.txt");
@a=<FL>;
close FL;
foreach $line (@a) {
chomp $line;
@b=split "\t",$line;
print "$line\n";
#print "@b\n";
}