open (T,"gene.txt");
open (R,">res.txt");
while($line=<T>)
{
	chomp $line;
	#print "$line\n";
	$seq=substr($line,5);
	
	print R "$seq\n";
	
	#last;
		
	}

close T;
close R;