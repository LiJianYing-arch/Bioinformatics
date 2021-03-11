$filename="p53_single_line.fasta";
open(T,"$filename")||die "Cannot open file $filename!\n";
while($line=<T>)
{
	if($line=~m/P31947/)
	{
		print "$line";
		$line=<T>;
		print "$line";
		}
	
	}
	close(T);