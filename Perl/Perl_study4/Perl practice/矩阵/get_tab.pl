$filename="input.tab";

open(RES,">ouput.tab");

open(T,"$filename")||die "Cannot open file $filename!\n";

$line=<T>;

while($line=<T>)
{
	chomp $line;
	@line=split('	',$line);
	
	print RES "$line[8] $line[9]\n";
	
	
	}
	close(T);
	close(RES);