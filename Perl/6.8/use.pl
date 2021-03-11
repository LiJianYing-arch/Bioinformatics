#hash of hash;
#%ha (A,@a,B,@b,C,3);
%ha=(
 name =>["aa","bb","cc","dd"],
 pet=>["11","22","33","44"],
);
print "$ha{name}\n";
print "$ha{name}[2]\n";
print "$ha{pet}[1]\n";

for $c (keys %ha) {
print "$ha{$c}\n";
};

for $c (keys %ha %name) {
print "$ha{$c}\n";
};
