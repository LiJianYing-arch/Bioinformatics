$filename="test.txt";
%hash=();
open(T,"$filename")||die "Cannot open file $filename!\n";
while($line=<T>)
{
	chomp $line;
	$hash{"$line"}++;
	}
	close(T);
	
for $t ( keys %hash)
{
	print "$t $hash{$t}\n";
	}