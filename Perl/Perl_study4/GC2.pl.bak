$DNA='AACCGTTAATGGGCATCGATGCTATGCGAGCTatccccgtccgt';
@DNA=split('',$DNA);

$A=$C=$T=$G=0;
for $nuc (@DNA)
{
	if($nuc eq 'A'||$nuc eq 'a')
	{		$A++;		}
	elsif($nuc eq 'C'||$nuc eq 'c')
	{		$C++;		}
		elsif($nuc eq 'T'||$nuc eq 't')
	{		$T++;		}
		elsif($nuc eq 'G'||$nuc eq 'g')
	{		$G++;		}
	
	}
	
	print "$A  $C  $T  $G  ";
	$n=@DNA;
	$GC_percent=($G+$C)/$n;
	
	print "$GC_percent";