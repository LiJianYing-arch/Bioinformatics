$list="list.txt";
open (T,"$list");
@list=<T>;
close T;

###########################################

open(RES,">all2.fasta");

for $filename (@list)
{
	chomp $filename;
		#
	open(F,"$filename")||die "Cannot open file $filename!\n";
	while($line=<F>)
	{
		chomp $line;
		print RES "$line\n";
	}
	close(F);
	#
	
	}


close(RES);



#	#