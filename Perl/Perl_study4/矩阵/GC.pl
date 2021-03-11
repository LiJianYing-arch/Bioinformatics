$DNA='AACCGTTAATGGGCATCGATGCTATGCGAGCT';
@DNA=split('',$DNA);

$A=$C=$T=$G=0;
for $nuc (@DNA)
{
	if($nuc eq 'A')
	{		$A++;		}
	elsif($nuc eq 'C')
	{		$C++;		}
		elsif($nuc eq 'T')
	{		$T++;		}
		elsif($nuc eq 'G')
	{		$G++;		}
	
	}
	
	print "$A  $C  $T  $G  ";
	$n=@DNA;
	$GC_percent=($G+$C)/$n;
	
	print "$GC_percent";