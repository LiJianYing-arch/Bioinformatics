@nu_n=(
['A',0],
['T',0],
['C',0],
['G',0]
);

$a='C';
for $i (0..3)
{
if($a eq $nu_n[$i][0])
{$nu_n[$i][1]++;}
}

for(@nu_n)
{print "@$_\n";}