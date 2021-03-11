##################### build hash with barcodes
%hash_bar=();
$filename="barcodes.txt";
open(T,"$filename")||die "Cannot open file $filename!\n";
while($line=<T>)
{
	chomp $line;
	@line=split(/	/,$line);
	$hash_bar{"$line[1]"}=$line[0];
	}
	close(T);
########################

for $t (keys %hash_bar)
{print "$t $hash_bar{$t}\n";
	open(R,">$hash_bar{$t}.fastq");
	close R;
		}

###
open(R2,">unfound.fastq");
close(RES);
$filename="test.fastq";
open(T,"$filename")||die "Cannot open file $filename!\n";
while($line1=<T>)
{
	$line2=<T>;
	$line3=<T>;
	$line4=<T>;
	
	$sw=1;
	
	for $t (keys %hash_bar)
	{
	if($line2=~m/^$t/)
	{
		open(R,">>$hash_bar{$t}.fastq");
				
		print R $line1;
		print R $line2;
		print R $line3;
		print R $line4;
		close R;
		$sw=0;last;
		}
	}
	print "-----------------$sw\n";
	
	if($sw==1)
	{
		print R2 $line1;
		print R2 $line2;
		print R2 $line3;
		print R2 $line4;
		
		}
	
	}
	close(T,R,R2);