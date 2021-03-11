#each用于迭代访问整个哈希
%hash=qw(Beijing 100000 Shanghai 200001 Nanjing 210001 Shenyang 110001);
while(($keys,$values)=each %hash){
print "$keys $values\n";
}
