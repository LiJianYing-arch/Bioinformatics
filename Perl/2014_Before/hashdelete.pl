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
#delete函数：删除哈希中某个键及其对应的值
#exists函数：用来检查哈希中是否存在某个键，与键对应的值无关