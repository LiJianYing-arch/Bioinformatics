$filename="input.tab";
open(RES,">ouput.fasta");
open(T,"$filename")||die "Cannot open file $filename!\n";
$line=<T>;
$name=1;
while($line=<T>)
{
	chomp $line;
	@line=split('	',$line);
	print RES ">$name\n$line[0]\n";$name++;
	
	}
	close(T);
	close(RES);