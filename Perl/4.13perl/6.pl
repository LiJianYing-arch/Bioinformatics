#!/usr/bin/perl;
@word1=("one","two","three");
@word2=(1,2,3);
@word=(@word1,@word2);
@word3=unshift("@word","2009");
print "@word3\n";
