
@a=(1,2,3,4);

print "@a";
print "\n";

$a[4]=5;

print "@a";
print "\n";

$a[2]=5;
print "@a";
print "\n";

#$a[0]=1;
#$a[1]=2;
#$a[2]=3;

for $i (0..2)
{
	$a[$i]=0;
	}
	
print "!!!  @a";

@array=();

@array=('a','b','c','d','e');

print "\n";

print "$array[2]";

$a=4;
$b=6;

@array2=($a,$b);

print $array2[1];

@bases = ('A', 'C', 'G', 'T');
print "@bases";
print "\n";
print "\n";

@bases2=@bases;
print "@bases2";

$n=@bases;
print "$n";

