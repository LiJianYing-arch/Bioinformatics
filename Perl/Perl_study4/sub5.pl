$a=4;$b=8;

$r=&add($a,$b);

print "$r";



sub add
{
	local(@d,$r);
	@d=@_;
	
	$r=$d[0]*$d[1];
	
	return $r;
	
	}
	
	




