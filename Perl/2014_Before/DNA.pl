#!/usr/bin/perl
chomp( $dna= <STDIN> );
@DNA = split( '', $dna );# 注意将碱基分割开来
$count_of_A = 0;
$count_of_C = 0;
$count_of_G = 0;
$count_of_T = 0;
foreach (@DNA){
if( $_ eq 'A' ) {++$count_of_A;}#foreach在需要控制变量的地方，如果不加指定，会使用默认变量$_
if( $_ eq 'C' ) {++$count_of_C;}
if( $_ eq 'G' ) {++$count_of_G;}#eq 是字符串比较，== 是数字比较
if( $_ eq 'T' ) {++$count_of_T;}
}
print "A = $count_of_A\n";
print "C = $count_of_C\n"; 
print "G = $count_of_G\n";
print "T = $count_of_T\n";
