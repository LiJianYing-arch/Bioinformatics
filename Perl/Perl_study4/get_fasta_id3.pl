$filename="p53.fasta";
open(R,">p53_name.txt");

open(T,"$filename")||die "Cannot open file $filename!\n";
while($line=<T>)
{
	
	#>sp|P61981|1433G_HUMAN 14-3-3 protein gamma OS=Homo sapiens GN=YWHAG PE=1 SV=2

	if($line=~m/^>sp\|(.*)\|.*_(.*?) /)
	{
		print "$1 $2\n";
		}
	
	}
	close(T,R);