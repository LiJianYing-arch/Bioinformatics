$a=4;

$r=&lf($a);

print "$r";



sub lf
{
	local($d,$r);
	$d=@_[0];
	$r=$d**3;
	return $r;
	
	}
	
	




