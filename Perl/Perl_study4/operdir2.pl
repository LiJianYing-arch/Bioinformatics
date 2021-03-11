$filename="input3.txt";
open(T,"../$filename")||die "Cannot open file $filename!\n";
while($line=<T>)
{
print "$line";
}
close(T);


