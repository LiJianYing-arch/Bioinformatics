$s="a,b,c";
@a=split(/,/,$s);
@b=split(/,/,$s,1);
print "@a\n";
print "@b\n"
#split函数语法：split(/模式/，分割串，长度)作用：对数组的元素进行分隔