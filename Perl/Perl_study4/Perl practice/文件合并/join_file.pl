open(LIST,"list")||die "Cannot open file !\n";
@list=<LIST>;
close(LIST);

open (R,">joined_pro.fasta");
for $filename (@list)
{
	open (T,"$filename");
	while($line=<T>)
	{
		print R $line;
		}
	close T;
	print R "\n";
	}
close R;