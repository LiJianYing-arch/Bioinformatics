%gene_exp=('recA', '2.30', 
'recB', '2.27' ,
'recC', '2.42' ,
'recD', '2.13' ,
'recF',  '1.24');
@keys=keys %gene_exp;#keys返回键列表，values返回值列表
@values=values %gene_exp;
print "@keys\n";
print "@values\n";
print "Enter the gene name:"; 
chop ($find=<STDIN>); 
print "$find has the expression value $gene_exp{$find}\n"; 
#练习：对下表中的基因及相应的表达量构建哈希，从键盘输
#入其中一个基因名，并打印其相应的表达量。
