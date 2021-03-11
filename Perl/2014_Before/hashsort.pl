%hash=('Beijing', 107, 'Shanghai', 98, 'Nanjing', 100, 'Shenyang', 927);
foreach $key ( sort { $hash{$a} <=> $hash{$b} } keys %hash){
   print "$key: $hash{$key}\n"; ##注意打印hash的键值
}
print "\n";
foreach $key ( sort { $hash{$b} <=> $hash{$a} } keys %hash){
   print "$key: $hash{$key}\n";
}
print "\n";
foreach $key ( sort { $hash{$a} cmp $hash{$b} } keys %hash){
   print "$key: $hash{$key}\n";
}
print "\n";
foreach $key ( sort { $hash{$b} cmp $hash{$a} } keys %hash){
   print "$key: $hash{$key}\n";
}
#cmp 等同于<=>