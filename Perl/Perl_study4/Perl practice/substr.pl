$line="ATCGGTGAGCGCGGCAGG\n";
chomp $line;

$seq=substr($line,3);
print "$seq";

