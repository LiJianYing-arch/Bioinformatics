%nu_n=('A',0,'T',0,'C',0,'G',0);

#print $nu_n{"A"};

chomp($dna=<STDIN>);
@dna=split(//,$dna);
for $a (@dna)
{	$nu_n{"$a"}++;	}
	

print "A:";print $nu_n{"A"};print "\n";
print "T:";print $nu_n{"T"};print "\n";
print "G:";print $nu_n{"G"};print "\n";
print "C:";print $nu_n{"C"};print "\n";

print "\n";
print "\n";

for $t (sort keys %nu_n)
{
	print "$t $nu_n{$t}\n";
	
	}