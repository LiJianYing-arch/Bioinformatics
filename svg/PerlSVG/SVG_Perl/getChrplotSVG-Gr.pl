#!/usr/bin/perl -w 
use SVG;

my $file = shift ;
my $file2 = shift ; # length

my %hash = () ;
open IN,"<",$file ;
while (<IN>){
    chomp ;
    my @regions = split ;
    push(@{$hash{"$regions[3]"}},[$regions[4],$regions[5]]) ;
}
my %hash2 = () ;
open IN2,"<",$file2 ;
while (<IN2>){
    chomp ;
    my @regions = split ;
    $hash2{"$regions[0]"} = $regions[1] ;
}
my $width = 300 ;
my $height = 100 ;
my $svg=SVG->new('width',$width,'height',$height);
my $h = 5 ;
for my $key (sort keys %hash){
    print $key,"\n" ;
    my $chr = "" ;
    if ($key =~ /(.*?)_(.*)/){ $chr = $2; }
    my @value = @{$hash{"$key"}} ;
    $svg->text(x=>8, y=>$h+0.5,'font-size'=>2)->cdata("$chr");
    $svg->rect(x => 15, y => $h-1.5, width => $hash2{"$key"}/1000000, height => 3, fill=>'grey');
    for my $tmp (@value){
	my $start = $tmp->[0]/1000000 ;
	my $end = $tmp->[1]/1000000 ;
	$svg->rect(x => 15, y => 150, width => 200, height => 200);
	$svg->line(x1=> $start+15,y1=>$h, x2=>$end+15 ,y2=>$h,stroke=>'red',"stroke-width"=>3);		
    }
    $h += 5 ;
}
my $x = $svg->group(id=>'group_x', style=>{stroke=>'black','stroke-width',0.3} ); 
$x->line(x1=>15, y1=>70, x2=>105, y2=>70);
$x->line(x1=>15, y1=>70, x2=>15, y2=>69);
$x->line(x1=>25, y1=>70, x2=>25, y2=>69);
$x->line(x1=>35, y1=>70, x2=>35, y2=>69);
$x->line(x1=>45, y1=>70, x2=>45, y2=>69);
$x->line(x1=>55, y1=>70, x2=>55, y2=>69);
$x->line(x1=>65, y1=>70, x2=>65, y2=>69);
$x->line(x1=>75, y1=>70, x2=>75, y2=>69);
$x->line(x1=>85, y1=>70, x2=>85, y2=>69);
$x->line(x1=>95, y1=>70, x2=>95, y2=>69);
$x->line(x1=>105, y1=>70, x2=>105, y2=>69);

$svg->text(x=>14.5, y=>72,'font-size'=>2)->cdata('0');
$svg->text(x=>24, y=>72,'font-size'=>2)->cdata('10');
$svg->text(x=>34, y=>72,'font-size'=>2)->cdata('20');
$svg->text(x=>44, y=>72,'font-size'=>2)->cdata('30');
$svg->text(x=>54, y=>72,'font-size'=>2)->cdata('40');
$svg->text(x=>64, y=>72,'font-size'=>2)->cdata('50');
$svg->text(x=>74, y=>72,'font-size'=>2)->cdata('60');
$svg->text(x=>84, y=>72,'font-size'=>2)->cdata('70');
$svg->text(x=>94, y=>72,'font-size'=>2)->cdata('80');
$svg->text(x=>104, y=>72,'font-size'=>2)->cdata('90');

$svg->text(x=>45, y=>75,'font-size'=>2)->cdata('chromosome length (Mb)');

my $out = $svg->xmlify;
open SVGFILE, ">Grgenome_temp.svg";
print SVGFILE $out;

