$filename="input2.txt";
open(T,"./test/$filename")||die "Cannot open file $filename!\n";
while($line=<T>)
{
print "$line";
}
close(T);


