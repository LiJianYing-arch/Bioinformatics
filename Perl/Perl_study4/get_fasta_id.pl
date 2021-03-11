$filename="p53.fasta";
open(R,">p53_name.txt");

open(T,"$filename")||die "Cannot open file $filename!\n";
while($line=<T>)
{
	if($line=~m/^>/)
	{print R $line;}
	
	}
	close(T,R);