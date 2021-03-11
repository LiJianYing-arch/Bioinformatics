$string='GCATGTGTAGCTGATCGAGCTCATG';

print "$string\n";

$string =~ tr/ATCGatcg/TAGCtagc/;

print "$string\n";

$string_r=reverse $string;

print "$string_r\n";

