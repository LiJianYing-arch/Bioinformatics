$filename="matrix.txt";

open(T,"$filename")||die "Cannot open file $filename!\n";

@Matrix=();
$i=0;
while($line=<T>)
{
	chomp $line;
	@line=split(' ',$line);
	
	for $j (0..@line-1)
	{$Matrix[$i][$j]=$line[$j];}
	$i++;
	
	}
	close(T);
	
	
for(@Matrix)
{print "@$_\n";}

	
	
	