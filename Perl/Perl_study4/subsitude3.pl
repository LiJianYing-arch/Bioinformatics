$string='        12 aactactgtc ttcacgcaga aagcgtctag ccatggcgtt agtatgagtg tcgtgcagcc';

print "$string\n";

$string =~ s/ +|\d//g;

print "$string\n";
