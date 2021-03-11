#!/usr/bin/perl; -w
@array=qw(12 23 58 96 54 1);
#@sorted=sort(@array);
#print "@sorted\n";
#@sorted=sort{$b<=>$a} @array;
@sorted1= reverse sort(@array);
@sorted2=sort reverse(@array);
print "@sorted1\n";
print "@sorted2\n";
#print "****"x10;