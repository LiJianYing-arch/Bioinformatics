#!/usr/bin/perl
@words=qw(qqq bbb ddd aaa jjj);
#@sorted=sort @words;
@sorted=sort{$b <=> $a} @words;  #reverse
print "@sorted\n";
@sorted= reverse sort(@words);   #@sorted= sort reverse(@words);
print "@sorted\n";