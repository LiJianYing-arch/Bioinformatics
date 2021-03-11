#!/usr/bin/perl
@num=(1..5);
foreach $xx (@num){
$xx x= 10;
print "$xx\n";
}
print "@num\n";