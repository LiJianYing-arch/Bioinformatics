$filename="p53_lines.fasta";
open(R,">p53_single_line.fasta");
open(T,"$filename")||die "Cannot open file $filename!\n";
##
$line=<T>;
chomp $line;
	if($line=~m/^>/)
	{
	print R"$line";
	print R"\n";
	}
	else
	{
		print R"$line";
		}

##
while($line=<T>)
{
	chomp $line;
	if($line=~m/^>/)
	{
	print R"\n$line";
	print R"\n";
	}
	else
	{
		print R"$line";
		}
	}
	print R"\n";
	
	
	
	close(R);
	close(T);