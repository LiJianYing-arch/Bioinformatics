$filename="p53.fasta";
open(RES,">p53_ids.txt");
open(T,"$filename")||die "Cannot open file $filename!\n";
while($line=<T>)
{
	if($line=~m/^>/)
	{
		$id=substr($line,4,6);
		print RES "$id";
		print RES "\n";
		
		
		}
	
	}
close(RES);	close(T);