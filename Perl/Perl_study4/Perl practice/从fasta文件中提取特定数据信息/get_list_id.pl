$filename="p53_single_line.fasta";
open(T,"$filename")||die "Cannot open file $filename!\n";
while($line=<T>)
{
	if($line=~m/P31947/)
	{
		open(out,">result.txt");
		while($line=<T>)
		{
			print out $line;
			
			}
		
		close(out);
		
		
		}
	
	}
	close(T);