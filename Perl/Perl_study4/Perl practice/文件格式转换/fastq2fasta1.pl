$filename="test.fastq";
open(T,"$filename")||die "Cannot open file $filename!\n";
while($line1=<T>)
{
	$line2=<T>;
	$line3=<T>;
	$line4=<T>;
	
	$line1=~s/@//g;
	$line1=~s/:/_/g;
	
	print ">$line1";
	print "$line2";
	
	
	
	}
	close(T);