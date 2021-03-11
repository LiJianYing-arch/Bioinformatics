$filename="input.tab";
@Matrix=();
$j=0;
open(T,"$filename")||die "Cannot open file $filename!\n";
while($line=<T>)
{
	chomp $line;
	@line=split(/	/,$line);	
	for $i (0..@line-1)
	{
		$Matrix[$j][$i]=$line[$i];
		}
	$j++;
	}
	close(T);
#################################	
open(RES,">pro.fasta");

for $n (1..100)
{
	print "$n\n";
	
	$pro_n=$n+1;
	print RES ">pro_$pro_n\n";
	print RES "$Matrix[$n][0] $Matrix[$n][8] $Matrix[$n][9]\n";
	
	#last;
	
	}
close(RES);



