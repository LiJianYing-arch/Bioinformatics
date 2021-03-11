$string='abcdefg';

print "$string\n";

$string =~ s/bcd/123/;

print "$string\n";

$line=~s/[\r\n]//;

chomp $line;