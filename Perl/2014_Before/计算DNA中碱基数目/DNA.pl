chomp( $dna= <STDIN> );
@DNA = split( '', $dna );# 注意将碱基分割开来
$count_of_A = 0;
$count_of_C = 0;
$count_of_G = 0;
$count_of_T = 0;
foreach (@DNA){
if( $_ eq 'A' ) {++$count_of_A;}
if( $_ eq 'C' ) {++$count_of_C;}
if( $_ eq 'G' ) {++$count_of_G;}
if( $_ eq 'T' ) {++$count_of_T;}
}
print "A = $count_of_A\n";
print "C = $count_of_C\n";
print "G = $count_of_G\n";
print "T = $count_of_T\n";
