$filename="sequence.gb";
open(T,"$filename")||die "Cannot open file $filename!\n";
while($line=<T>)
{
	if($line eq "ORIGIN      \n")
	{
		open(RES,">result.txt");
		while($line=<T>)
		{
			print RES $line;
			
			}
		
		close(RES);
		
		
		}
	
	}
	close(T);