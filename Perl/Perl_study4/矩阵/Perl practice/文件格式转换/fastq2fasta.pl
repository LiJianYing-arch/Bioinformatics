$filename="test.fastq";
open(RES,">test.fasta");

$n=0;
open(T,"$filename")||die "Cannot open file $filename!\n";
while($line1=<T>)
{
	$n++;
	chomp $line1;
	$line2=<T>;chomp $line2;
	$line3=<T>;chomp $line3;
	$line4=<T>;chomp $line4;

   print RES ">$line1\n";
   print RES "$line2\n";   	
	
#	if($n>=1000)
#	{	last;}
	
	}
	close(T);
close(RES);