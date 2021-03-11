$filename="gene.txt";
open(RES,">out.txt");
open(RES2,">out2.txt");
open(T,"$filename")||die "Cannot open file $filename!\n";
while($line=<T>)
{
	chomp $line;
	$n=(length $line);
	if($n>=25)
	{
		print RES "$line\n";
		}
	else 
	{
			print RES2 "$line\n";
	}
	
	
	}
	close(T);close(RES,RES2);