#!/usr/bin/perl;
@words=("one","two","three");  #EDitplus
shift (@words);
unshift (@words,"five");
print "@words\n";
