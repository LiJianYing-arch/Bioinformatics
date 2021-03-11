#!/usr/bin/perl -w
%hash=qw(a 1 b 2 c 3);
@k=keys %hash;
@v=values %hash;
print "@k\n";
print "@v\n";
while(($keys,$values)=each %hash){
    print "$keys $values\n";
}
foreach $keys (sort keys %hash){
    $value=$hash{$keys};
    print "$keys=>$value\n";
}
