$astring = "Larry-David-Roger-Ken-Michael-Tom";
$bstring = "1,45,-1,39,596,89,1000";
@array1 = split( '-', $astring );
@array2 = split( ',', $bstring );
@sort1 = sort(@array1);
@sort2 = sort{$b<=>$a} @array2;
print "@array1\n";
print "@array2\n";
print "@sort1\n";
print "@sort2\n"

