$string='AACCACACCTATAAAGAATTTCACAGAATGGCAAAGAAAATTT';

print "$string\n";

$string=~tr/ATCGatcg/TAGCtagc/;
$string=reverse $string; 

print "$string\n";

