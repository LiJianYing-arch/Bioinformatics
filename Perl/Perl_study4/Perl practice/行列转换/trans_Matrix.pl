$filename="input.tab";
@Matrix=();
$j=0;
open(T,"$filename")||die "Cannot open file $filename!\n";
while($line=<T>)
{
	chomp $line;
	@line=split(/ /,$line);	
	for $i (0..@line-1)
	{
		$Matrix[$j][$i]=$line[$i];
		}
	$j++;
	}
	close(T);
#################################	
open(RES,">res.tab");

for $i1 (0..3)
{
	for $j1 (0..2)
	{
		print "$Matrix[$j1][$i1]	";		
		
		}
		print "\n";

	
	}
close(RES);