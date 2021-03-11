%abc=();
$abc{1}='a';
$v='a';
for $i (2..26)
{
	$v++;
	$abc{$i}=$v;
	}
	
print "$abc{10}";