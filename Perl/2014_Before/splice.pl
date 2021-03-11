@a=(6..15);
@c=splice(@a,2,6);
$m=scalar(@c);
print "$m\n";
print "@a\n";
print "@c\n";

#目标数组, 起始位置,删除长度
