$string1 = "This is test";
$retval  = chomp( $string1 );
print " Choped String is : $string1\n";
print " Number of characters removed : $retval\n";
$string1 = "This is test\n";#注意！！！！
$retval  = chomp( $string1 );
print " Choped String is : $string1\n";
print " Number of characters removed : $retval\n";
#chomp是一个函数。作为一个函数，它有一个返回值，为移除字符的个数