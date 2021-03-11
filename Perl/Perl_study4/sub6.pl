@A=&readmatrix("Matrix.txt");
for(@A){print "@$_\n";}

sub readmatrix
{
	local($mx,$l,@Matrix);
	open(MX,"@_")||die"can't open @_!\n";
	$l=0;
	while($mx=<MX>)
	{
		$mx=~s/[\r\n]$//g;
		@{$Matrix[$l]}=split(/	| /,$mx);
		$l++;
		}
		close MX;
		return(@Matrix);
	}