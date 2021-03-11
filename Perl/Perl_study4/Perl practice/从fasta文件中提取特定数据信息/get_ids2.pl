$filename="p53.fasta";
open(RES,">p53_ids.txt");
open(T,"$filename")||die "Cannot open file $filename!\n";
while($line=<T>)
#>sp|P61981|1433G_HUMAN 14-3-3 protein gamma OS=Homo sapiens GN=YWHAG PE=1 SV=2
{
	if($line=~m/^>sp\|(.*)\|/)
	{
		$id=$1;
		print RES "$id";
		print RES "\n";
		
		
		}
	
	}
close(RES);	close(T);