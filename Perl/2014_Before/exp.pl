%gene_exp=('recA', '2.30', 
'recB', '2.27' ,
'recC', '2.42' ,
'recD', '2.13' ,
'recF',  '1.24');
@keys=keys %gene_exp;#keys���ؼ��б�values����ֵ�б�
@values=values %gene_exp;
print "@keys\n";
print "@values\n";
print "Enter the gene name:"; 
chop ($find=<STDIN>); 
print "$find has the expression value $gene_exp{$find}\n"; 
#��ϰ�����±��еĻ�����Ӧ�ı����������ϣ���Ӽ�����
#������һ��������������ӡ����Ӧ�ı������
