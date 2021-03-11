#!/usr/bin/perl;
@array=(2,5,9,11,55,31);
print "@array\n";
$length=scalar(@array);
print "$length\n";
@sorted=sort{$a<=>$b}(@array);
@sorted1=sort{$b<=>$a}(@array);
print "@sorted1\n";
print "@sorted\n";