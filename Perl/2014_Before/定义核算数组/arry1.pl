@bases = ('A', 'C', 'G', 'T');
@order = qw (First Second Third Fourth);
print "Here are the array elements:";
$i=0;
while( $i<4 ){
print "\n$order[$i] element: $bases[$i]";
$i++;
}
