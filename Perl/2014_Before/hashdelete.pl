%last_name = (
 "Jaime" => "Fraser",
 "Brendan" => "Fraser",
 "Lenny" => "Teytelman",
 "Venky" => "Iyer",
);
print scalar keys %last_name ,"\n"; 
delete $last_name{"Jaime"};         #!!!
print scalar values %last_name ,"\n"; 
if (exists $last_name{"Jaime"}){
    print "Jaime has a last name!";
}
else{
    print "Your name dose not exist!";
}
#delete������ɾ����ϣ��ĳ���������Ӧ��ֵ
#exists��������������ϣ���Ƿ����ĳ�����������Ӧ��ֵ�޹�