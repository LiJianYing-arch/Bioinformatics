#!/usr/bin/perl
chomp( $dna= <STDIN> );
@DNA = split( '', $dna );# ע�⽫����ָ��
$count_of_A = 0;
$count_of_C = 0;
$count_of_G = 0;
$count_of_T = 0;
foreach (@DNA){
if( $_ eq 'A' ) {++$count_of_A;}#foreach����Ҫ���Ʊ����ĵط����������ָ������ʹ��Ĭ�ϱ���$_
if( $_ eq 'C' ) {++$count_of_C;}
if( $_ eq 'G' ) {++$count_of_G;}#eq ���ַ����Ƚϣ�== �����ֱȽ�
if( $_ eq 'T' ) {++$count_of_T;}
}
print "A = $count_of_A\n";
print "C = $count_of_C\n"; 
print "G = $count_of_G\n";
print "T = $count_of_T\n";
