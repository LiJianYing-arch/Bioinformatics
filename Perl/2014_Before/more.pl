$max=20;
$value=1;
$count=0;
while($count<$max)
{
$value=$value+1;
$composite=0;
OUTER: for ($i=2;$i<$value;$i=$i+1)
{
for ($j=$i;$j<$value;$j=$j+1)
{
if (($j*$i)==$value))
{
$composite=1;
last OUTER;
   }
  }
}
if (! $composite)
{ 
$count=$count+1;
print "$value is primer\n";
  }
 }

