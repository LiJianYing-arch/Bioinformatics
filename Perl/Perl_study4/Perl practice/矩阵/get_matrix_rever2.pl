$filename="matrix.txt";

open(T,"$filename")||die "Cannot open file $filename!\n";
#$line=<T>;################### skip head line
@Matrix=();
$i=0;
while($line=<T>)
{
	chomp $line;
	@line=split(' ',$line);###################### 
	
	for $j (0..@line-1)
	{$Matrix[$i][$j]=$line[$j];}
	$i++;
	
	}
	close(T);
	
	
	

@Matrix_r=();
for $i (0..2)
{
	for $j (0..1)
	{
		
		$Matrix_r[$j][$i]=$Matrix[$i][$j];
		
		}
		
	}

	for(@Matrix_r)
	{print "@$_\n";}
	
