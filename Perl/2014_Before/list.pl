print "please input:\n";
@lines = <STDIN>;
print @lines;
print "\n";
$i=1;
foreach $line(@lines){
print "line$i: ".$line;
$i++;
}