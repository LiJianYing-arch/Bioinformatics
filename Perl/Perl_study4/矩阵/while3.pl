$i=1;
while($i<=100)
{
	if($i%7==0)
	{	print "*\n";}
	elsif($i%10==7)
	{print "*\n";	}
	elsif(int ($i/10)==7)
	{print "*\n";	}
	else
	{ print "$i\n";	}
	
	
	$i++;
	
	}



	