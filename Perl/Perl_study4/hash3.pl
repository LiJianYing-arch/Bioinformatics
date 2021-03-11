$DNA='ACTGCATGCATCAGCTACGATCGCATCGACTACG';

$DNA=$DNA;

@DNA=split('',$DNA);

%count=();
for $nuc (@DNA)
{		$count{$nuc}++;	}
	
for  $t (sort keys %count)
{
	print "$t $count{$t}";
	print "\n";
	}

$gc_per= ($count{C}+$count{G})/@DNA;

print "$gc_per";