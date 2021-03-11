$filename="test.fastq";
open(T,"$filename")||die "Cannot open file $filename!\n";
while($line1=<T>)
{
	$line2=<T>;
	$line3=<T>;
	$line4=<T>;
	
	print ">$line1$line2";
	
	
	
	}
	close(T);