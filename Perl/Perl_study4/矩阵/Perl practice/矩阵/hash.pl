%marks=(
Tom,98,
Jane,87,
Jack,65,
Edward,88,
Peter,99,
Jerry,87,
Smith,56
);

print "$marks{Jerry}";
print "\n";
print "\n";

for $t (sort keys %marks)
{
	print "$t $marks{$t}\n";
	
	}