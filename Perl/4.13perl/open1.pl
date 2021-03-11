#!/usr/bin/perl; -w
#while (defined($_=<STDIN>)) {
 #   print "I saw $_";
#}
#foreach (STDIN){
    #print "I saw $_";
#}
#while (defined($_=<>)) {
 #   chomp($_);
# print "I saw $_\n";
#}
while (<>){
    chomp;
    print "I saw $_\n";
}
