#!/usr/bin/perl
@number=(1,2,3,4,5);
$number[9]="five";
$num=$#number;
print "$num\n";
print "@number\n";
print "$number[2]\n";
@number=();
print "@number\n";