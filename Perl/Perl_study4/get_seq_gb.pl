$genome='';
$filename="sequence.gb";
open(T,"$filename")||die "Cannot open file $filename!\n";
while($line=<T>)
{
#print "$line";
if($line=~m/^ORIGIN/)
{
	while($line=<T>)
	{
		chomp $line;
		@line=split(/ +/,$line);
		
		#print "$line[2]$line[3]$line[4]$line[5]$line[6]$line[7]";
		$genome.="$line[2]$line[3]$line[4]$line[5]$line[6]$line[7]";
		}
	}
}
close(T);
  print $genome;
  $a=291;
  $b=321;
  $CDS=substr($genome,$a-1,$b-$a+1);
  print "\n";
  print "\n";
  print $CDS;
  
  