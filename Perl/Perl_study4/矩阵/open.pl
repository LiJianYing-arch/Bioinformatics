$filename="input.txt";

open (T,"$filename") || die "can not open $filename ";

while($line=<T>)
{
	chomp $line;
	
	
	print "$line\n";
	
	
	
	}
close (T);

