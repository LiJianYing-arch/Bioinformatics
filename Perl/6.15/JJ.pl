
while($DNA=~/t/ig){
$count_T++;
}
while($DNA=~/g/ig){
$count_G++;
}
while($DNA=~/c/ig){
$count_C++;
}
else($_eq err){
$err++;
}
}
print "A=$count_A\n";
print "T=$count_T\n";
print "G=$count_G\n";
print "C=$count_C\n";
print "ERR=$ERR\n";
