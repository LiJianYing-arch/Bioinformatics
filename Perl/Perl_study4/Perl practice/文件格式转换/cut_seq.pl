$filename="test.fastq";
open(RES,">out.fastq");


open(T,"$filename")||die "Cannot open file $filename!\n";
while($line1=<T>)
{
	chomp $line1;
	$line2=<T>;chomp $line2;
	$line3=<T>;chomp $line3;
	$line4=<T>;chomp $line4;

   print RES "$line1\n";
   $seq=substr($line2,0,90);
   print RES "$seq\n";   	
   print RES "$line3\n";
   $qv=substr($line4,0,90);
	 print RES "$qv\n";
	
	#last;
	
	}
	close(T);
close(RES);