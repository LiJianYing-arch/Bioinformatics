$filename="sequence.gb";
open(R,"$filename")||die "Cannot open file $filename!\n";
while($line=<R>)
{
	if($line eq "ORIGIN      \n")
	{
		open(RES,">result.txt");#�ļ���д��
		while($line=<R>)
		{
			print RES $line;
			
			}
		
		close(RES);
		
		
		}
	
	}
	close(R);