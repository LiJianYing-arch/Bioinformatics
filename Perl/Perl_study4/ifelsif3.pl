$a=<STDIN>;
chomp $a;

if($a>=0&&$a<=100)  
{
if($a >= 85)
{	print "great";	}
elsif($a >= 75)
{ print "good";	}
elsif($a >= 60)
{ print "pass";	}
elsif($a >= 40)
{ print "try again";	}
else
{ print "fail";	}
}
else
{print "error";}