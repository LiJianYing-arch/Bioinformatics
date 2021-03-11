#!/usr/bin/perl
#@num=(2,33,6,15,88,10,9,12);
#@sorted=sort@num;
#print "@sorted\n";
@num=(2,33,6,15,88,10,9,12);
@sorted=sort{$a<=>$b}(@num);
print "@sorted\n";