

open(L,"list.txt")||die "Cannot open file $filename!\n";
@list=<L>;
close(L);
########################
$filename="p53_single_line.fasta";
for $id (@list)
{
	chomp $id;
open(T,"$filename")||die "Cannot open file $filename!\n";
while($line=<T>)
{
	if($line=~m/$id/)
	{
		print "$line";
		$line=<T>;
		print "$line";
		last;
		}
	
	}
	close(T);
}