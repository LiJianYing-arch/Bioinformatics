%hash=();

$a='b';
for(1..10)
{
	$hash{$_}=$a;
	
	
	}
	
	for $t (sort keys %hash)
{
	print "$t $hash{$t}\n";
	
	}
	

