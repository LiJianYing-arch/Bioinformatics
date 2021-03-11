$filename="gene.txt";
open(RES,">out.txt");
open(T,"$filename")||die "Cannot open file $filename!\n";
while($line=<T>)
{
	chomp $line;
	$n=(length $line);
	if($n>=25)
	{
		print RES "$line\n";
		}
	
	
	}
	close(T);close(RES);