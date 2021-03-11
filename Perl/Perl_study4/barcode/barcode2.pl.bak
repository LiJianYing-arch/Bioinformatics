%barcode_list=();
$filename="barcode_list.txt";
open(T,"$filename")||die "Cannot open file $filename!\n";
while($line=<T>)
{
	chomp $line;
	@line=split(/	/,$line);
	$barcode_list{$line[1]}=$line[0];
	}
	close(T);
	

$filename="test.fastq";
open(T,"$filename")||die "Cannot open file $filename!\n";
while($line1=<T>)
{
	$line2=<T>;
	$line3=<T>;
	$line4=<T>;
	for $bl (5..7)
	{
	$head_seq=substr($line2,0,$bl);##
	if($barcode_list{$head_seq})
	{
	open(RES,">>$barcode_list{$head_seq}.fastq");
	print RES"$line1";
	
	$line2=substr($line2,$bl);##
	print RES"$line2";
	
	print RES"$line3";
	
	$line4=substr($line4,$bl);##
	print RES"$line4";
	close(RES);
  }
	else 
	{
	open(RES,">>rest.fastq");
	print RES"$line1";
	print RES"$line2";
	print RES"$line3";
	print RES"$line4";
	close(RES);
	}

}
}
	close(T);
	
	
	
	
#  if(not defined $A{$input}) {
#            print "Code $input not defined\n";
#      }
#    $code= $A{$input};