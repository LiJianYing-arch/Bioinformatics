$list="list.txt";
open(RES,">all.fasta");
open(T,"$list")||die "Cannot open file $list!\n";
while($filename=<T>)
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
close(T);
close RES;

