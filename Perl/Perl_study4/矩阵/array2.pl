$DNA='AACCGTTAATGGGCATCGATGCTATGCGAGCT';
print "$DNA\n";

@DNA=split('',$DNA);

print "@DNA\n";

print "!!$DNA\n";
$a=10;
$b=20;

for $i ($a-1..$b-1)
{
	print "$DNA[$i]";
	}



