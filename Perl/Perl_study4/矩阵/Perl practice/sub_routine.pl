
$sum=&hello("3","5");

print "$sum\n";




sub hello
{
	my $sum;
	my ($name1,$name2)=@_;

$sum=$name1+$name2;

return $sum;
}