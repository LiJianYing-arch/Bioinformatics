$filename="input";

open (T,"$filename.txt") || die "can not open $filename ";
open(R,">>output.txt");

while($line=<T>)
{
	chomp $line;
	
	
	print R "$line\n";
	
	
	}
close (T);
close (R);
