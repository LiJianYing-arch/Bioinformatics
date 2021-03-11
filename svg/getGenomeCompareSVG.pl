#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long;
use File::Basename qw(basename dirname fileparse); 
use IO::File;
use Data::Dumper;
use Pod::Text;
use SVG;
use Cwd qw(abs_path getcwd);
my $bin = dirname(abs_path($0));

my $genomeIndex = 1;
my (@len, @name, @syn, @expr,$width,$height, @thres, $out, @gap);
my ($drawpdf, $drawpng);
$width=1200;
$height=300;
my $dgap=9;
my $svg2xxxpath = "./";
GetOptions(
            'l=s'=>\@len,  
	    'r=s'=>\@name,
            's=s'=>\@syn,
	    'a=s'=>\@expr,
            't=i'=>\@thres,
            'g=s'=>\@gap,
            'o=s'=>\$out,
            'pdf!'=>\$drawpdf,
            'png!'=>\$drawpng,
	     'width=i'=>\$width,
		'height=i'=>\$height,
		'dgap=f'=>\$dgap,

          )|| &help;

if(!defined($out))
{
print <<"Usage End.";
Description:
usage:  1. perl $0 -l Ar.len -l Bn.len -l Co.len -s Ar.Bn.syn -s Bn.Co.syn -o new.svg
2. perl $0 -l Ar.len -r AABGI -l Bn.len -r Chr -l Co.len -r DTBGI -a "Chr*.delta" -len 10000 -a "Chr*.delta" -len 25000 -o new.svg -pdf -png
Usage:
-l          	infile          must be given
-runique 	ref namerequired
-s          	infile          -s / -a optional
-dgap            the gap between neighbour chromosme,default 9
-aexpression	-s / -a optional
-ttrim           lengthrequired
-o               out.svg         must be given 
--pdf            out.pdfwhether to generate pdf format
--png            out.pngwhether to generate png format
-width           picture width,default 1500
-height		 picture picture,default 300
-h          Help document
Usage End.
exit;
}

if(!defined($syn[0])){
my $exprs = $expr[0];
my $thress = $thres[0];
my $names = $name[0];
my $namee = $name[1];
my $command = "perl $bin/prepare.linear.pl -delta $exprs -len $thress -rref $names -out $names\_$namee";
system("$command");
my $d = $thress / 1000;
$d .= "k";
my $synfile = "$names\_$namee.$d.linear";
push @syn,$synfile;

$exprs = $expr[1];
$thress = $thres[1];
$names = $name[1];
$namee = $name[2];
$command = "perl $bin/prepare.linear.pl -delta $exprs -len $thress -rref $names -out $names\_$namee";
system("$command");
$d = $thress / 1000;
$d .= "k";
$synfile = "$names\_$namee.$d.linear";
push @syn,$synfile;

}

my $svg = SVG->new(width => $width, height =>$height);

my (%style, %rect, );
&iniSvg();
my $unit = 1000000; 
my @chr_spc_x = (12, 4, 6, 12, 4, 6) ;
my $chr_spc_y = 65;
my $chr_height = 8;
my $gap_ratio = 0.5;
my $curve = 30;
my %chr_style = %style;


my @colors= ("#F4BC7F","#CBCB67","#FF8989","#FF77FF","#EDBABA","#FFAE3E","#F3C000","#00E800","#92D87E","#BABAFF","#98C4FF","#FAA1FF","#0097c0","#999999","#CACA88","#E3B1FF","#C6C6C6","#999999","#FF92FF","#CCCCCC","#9CD0D0","#98CBFE","#0E0E00","#CCCCCC","#AEAE7A","#A6D800","#AEAE7A","#6CBF26","#ABABAB","#FF7474");
my @genome_colors = ('#BF368E', '#00803E', '#F4A6C8', '#BF368E', '#00803E', '#F4A6C8');


my @star_x; 
my @star_y;
my @chr_middle;
my $refpos = 1;
my %chrid_index;

my @all_genome;
my @all_orders;
my @genome_names;
my %chr_map;
for my $idx (0..$#len){
    $star_x[$idx] = 100;

    $star_y[$idx] = 40 + $chr_spc_y*$idx;
    push @all_genome, (&getGenomeLen($len[$idx]))[0];
push @all_orders, (&getGenomeLen($len[$idx]))[1];
$len[$idx] =~ /(.*).len/;
push @genome_names, $1;
}

my %genome_art = (genome    => $all_genome[1],
 order=> $all_orders[1],
 subgenome=> $genome_names[1],
                  star_x    => $star_x[1],
                  star_y    => $star_y[1],
                  chr_spc_x => $chr_spc_x[1],
                  chr_spc_y => $chr_spc_y,
                  height    => $chr_height, 
                  style     => \%style, 
                  txt_pos   => 'other');
#print Dumper %genome_art;die;
&drawGenome_ref(%genome_art);

sub drawGenome_ref
{
    my %p = (
        genome => '',
	order => '',
        star_x => 0,
        star_y => 0,
        height => 0,
        style => '',
        txt_pos => '', # med up down 
        @_,
    );
    &caluChrPos_ref($p{genome}, $p{order}, $p{star_x}, $p{chr_spc_x});
}

# calculate chr middle pos of AA.new
sub caluChrPos_ref
{
    my ($genome, $order, $star_x, $chr_spc_x) = @_;
    my @pos = ([$star_x], );
    for my $chr (@{$order}){ 
        $genome->{$chr}{x} = $pos[-1][0];
        push @{$pos[-1]}, $genome->{$chr}{len}/$unit;
        $genome->{$chr}{width} = $pos[-1][1];
        push @pos, [$pos[-1][0]+$pos[-1][1]+$chr_spc_x+$dgap];
        
        my $x = $genome->{$chr}{x};
my $width = $genome->{$chr}{len}/$unit;
#my $nx = $x+$width/2;
my $nx=$x+$width/2;

push @chr_middle, $nx;
$genome->{$chr}{x} = $pos[-1][0];
    }
    $refpos = 0;
}

%genome_art = (genome    => $all_genome[0],
 order=> $all_orders[0],
 subgenome=> $genome_names[0],
                  star_x    => $star_x[0],
                  star_y    => $star_y[0],
                  chr_spc_x => $chr_spc_x[0],
                  chr_spc_y => $chr_spc_y,
                  height    => $chr_height, 
                  style     => \%style, 
                  txt_pos   => 'up');
$genome_art{style}{fill} = $genome_colors[0];
&drawGenome(%genome_art);

for my $idx (0..$#syn){
    $genome_art{genome} = $all_genome[$idx+1];
$genome_art{order} = $all_orders[$idx+1];
$genome_art{subgenome} = $genome_names[$idx+1];
    $genome_art{star_x} = $star_x[$idx+1];
    $genome_art{star_y} = $star_y[$idx+1];
    $genome_art{chr_spc_x} = $chr_spc_x[$idx+1];
    $genome_art{txt_pos} = $idx == $#syn ? 'down' : 'other';
    $genome_art{style}{fill} = $genome_colors[$idx+1];
    &drawGenome(%genome_art);
    my @syn_region = &readSyn($syn[$idx]); 
    print Dumper @all_genome;
    my @pos = &caluSynPos(\@syn_region, @all_genome[$idx, $idx+1], 
                          $idx==0 ? 's' : $idx==$#syn ? 'e' : '1');
    &drawSyn($idx==0 ? 0 :  1,\@pos);
}
open my $OUT, '>', $out;
print $OUT $svg->xmlify();
close $OUT;

if($drawpng){
my $command = "$svg2xxxpath -dpi 150 $out -t png";
system($command);
}
if($drawpdf){
my $command = "$svg2xxxpath -dpi 150 $out -t pdf";
system($command);
}

sub drawGenome
{
    my %p = (
        genome => '',
order => '',
        star_x => 0,
        star_y => 0,
        height => 0,
        style => '',
        txt_pos => '', # med up down 
        @_,
    );

    &caluChrPos_query($p{genome}, $p{order}, $p{star_x}, $p{chr_spc_x});

    &drawGenomeName(%p);
   &drawSeriesRect(%p);
    &drawSeriesTxt(%p);

}


# plot chr using middle pos of AA.new
sub caluChrPos_query
{
    my ($genome, $order, $star_x, $chr_spc_x) = @_;
    my @pos = ([$star_x], );
    my $chr_middle_index = 0;
    for my $chr (@{$order}){ 
   if($chr_middle_index > $#chr_middle){
	$genome->{$chr}{x} = $pos[-1][0];
	push @{$pos[-1]}, $genome->{$chr}{len}/$unit;
	$genome->{$chr}{width} = $pos[-1][1];
	push @pos, [$pos[-1][0]+$pos[-1][1]+$chr_spc_x+$dgap];

#my $x = $genome->{$chr}{x};
	my $x = $chr_middle[$#chr_middle];
	my $width = $genome->{$chr}{len}/$unit;
	my $nx = $x+$width * 2;
#my $nx = $x+$width/2;
push @chr_middle, $nx;
$genome->{$chr}{x} = $pos[-1][0];
#next;
}
    my $middle_x = $chr_middle[$chr_middle_index];
    $chr_middle_index++;
    my $width = $genome->{$chr}{len}/$unit;
   
        $genome->{$chr}{x} = $middle_x - $width/2;
        push @{$pos[-1]}, $width;
        $genome->{$chr}{width} = $pos[-1][1];
        push @pos, [$pos[-1][0]+$pos[-1][1]+$chr_spc_x];
    }
    pop @pos;
}

sub drawGenomeName
{
    my %p = ( txt_pos => '', @_);
    my $genomename = $p{subgenome};  
    my %txt;
    $txt{x} = 40; 
    $txt{y} = $p{star_y} + 8;
    $txt{'text-anchor'} = 'middle' ; 
$txt{-cdata}=$genomename;
    $svg->text(%txt); 
}

sub drawSeriesRect
{   
    my %p = (@_);

    my %chr = %rect;
    $chr{height} = $p{height};
    $chr{y} = $p{star_y};
    $chr{rx} = '4';
    $chr{ry} = '4';

my $colorIndex = 0;
    for my $chr (@{$p{order}}){
    
        my $ref = [$p{genome}->{$chr}{x}, $p{genome}->{$chr}{width}];
        $p{genome}->{$chr}{y} = $p{star_y};
        $p{genome}->{$chr}{height} = $p{height};
        $chr{x} = $$ref[0];
        $chr{width} = $$ref[1];
        my %style = %{$p{style}};
        my %n_sty = %style;
        $style{'fill'} = 'white';
        if ($chr{width}<13){
            $chr{rx} = '0';
            $chr{ry} = '0';
        }
        $svg->rectangle(%chr, style=>\%style);
	my $num = &fetchNum($chr);
	my $color = $colors[$num];
        my %n_chr = %chr;
        $n_chr{y} = $p{star_y} + $p{height}*$gap_ratio*0.5;
        $n_chr{rx} = '1';
        $n_chr{ry} = '1';
        $n_chr{height} = $p{height}*$gap_ratio;
        $n_sty{"fill-opacity"} = '1';
        $n_sty{"stroke-width"} = '0';
        $n_sty{"fill"} = $color;
        #$svg->rectangle(%n_chr, style=>\%n_sty);remove middle rect
    }
}

sub drawSeriesTxt
{
    my %p = ( txt_pos => '', @_);
    for my $chr (@{$p{order}}){
        my $ref = [$p{genome}->{$chr}{x}, $p{genome}->{$chr}{width}];
        my $chr_num = &fetchNum_text($chr);  
        my %txt;
        if ($p{txt_pos}=~/(up)|(down)/){

            $txt{x} = $$ref[0]+$$ref[1]/2;
            $txt{y} = $p{txt_pos} eq 'up' ? 
                      $p{star_y} - $p{height}/2 :
                      $p{star_y} + $p{height}*5/2 + 4;
            $txt{'text-anchor'} = 'middle' ; 
        }elsif($chr=~/old/){
            next if $chr_num%10;
            $txt{x} = $$ref[0]+$$ref[1]/2;
            $txt{y} = $p{star_y} + $p{height}*5/2 + 4;
        }else{
            $txt{x} = $$ref[0]+$$ref[1]+5;
            $txt{y} = $p{star_y} + $p{height}*3/2;
            $txt{'text-anchor'} = 'start';
        }
$txt{-cdata}=$chr_num;
#print "$txt{x}..$txt{y}..$chr_num\n";
if($p{txt_pos} eq "other"){next;}
#if($genomeIndex == 2){next;}
        $svg->text(%txt); 
    }
$genomeIndex++;
}

sub readSyn
{
    my $file = shift;
    open my $IN,'<',$file;
    my @res;
    while(<$IN>){
        chomp;
        my ($a_chr, $as, $ae, $b_chr, $bs, $be, $lend) = split; 
        push @res, [$a_chr, $as, $ae, $b_chr, $bs, $be, $lend];
    }
    return (@res);
}

sub getGenomeLen
{
    my $IN = IO::File->new(shift);
my %res;
    my @orders;
my $index = 0;
    while(<$IN>){
        chomp;
        my ($chr, $len) = (split);
$res{$chr}{len} = $len ; 
        $orders[$index] = $chr ;
$chrid_index{$chr} = $index;
$index++;
    }
    return (\%res,\@orders);
}

sub iniSvg
{
    %style = (
        'stroke'         => 'black',
        'fill'           => 'white',
        'stroke-width'   => '0.3',
        'stroke-opacity' => '1',
        'fill-opacity'   => '0',
    );

    %rect = (
        x       => 0,
        y       => 0,
        width   => 0,
        height  => 0,
    );
}

sub fetchNum_text
{   
    my $name = shift;
    my $num = $name=~/(\d+)/ ?  $1 : die"cannot find a num";
    $num=~s/^0+//;
    return $num;
}

sub fetchNum
{   
    #print "$name\n";
    my $name = shift;
    my $num = "";#$name=~/(\d+)/ ?  $1 : die"cannot find a num";
    #$num=~s/^0+//;
$num = $chrid_index{$name};
    return $num;
}

sub drawSyn
{
    my ($staus,$pos) = @_;
    my $colorN;
    if($staus==0){
	$colorN=3;
}else{
	$colorN=1;
    }
my $index = 0;
    for my $ref(@{$pos}){
        my %syn_style = %style;
        $syn_style{"fill-opacity"} = 0.1;
	$syn_style{"stroke-width"} = 0.5;
	$syn_style{"stroke-opacity"} = 0.1;
	my $num = &fetchNum($$ref[$colorN]);
	my $color = $colors[$num];
        $syn_style{"stroke"} = $colors[$num];
        $syn_style{fill} = $color;
        $svg->path(%{$$ref[0]}, style => \%syn_style);
    }
}

sub caluSynPos
{
    my ($syn, $up, $down, $staus) = @_;
   
my @res;
    for my $ref (@$syn){
        my @up_x   = map { $_/$unit + $up->{$$ref[0]}{x}} @{$ref}[1,2];
        my @down_x = map { $_/$unit + $down->{$$ref[3]}{x}} @{$ref}[4,5];
        my $up_y   =   $up->{$$ref[0]}{y};#+   $up->{$$ref[0]}{height}*0.5 ; 

        my $up_cont_y = $up_y + $curve;
        my $downY = $down->{$$ref[3]}{y}+ $down->{$$ref[3]}{height};

	my $d = $up->{$$ref[0]}{y};
	my $f = $up->{$$ref[0]}{height}*0.5;
	my $upY=$up->{$$ref[0]}{y}+$up->{$$ref[0]}{height};
	my $down_y= $down->{$$ref[3]}{y};
        my $down_cont_y = $down_y - $curve ;
	#print "$$ref[0]..$up_cont_y..$d..$f..$up_y..\n";sleep 1;
	# my $point = { 'd' => "M $up_x[0] $up_y ".
       #     "C $up_x[0] $up_cont_y $down_x[0] $down_cont_y $down_x[0] $down_y ".
       #     "H $down_x[1] ".
       #     "C $down_x[1] $down_cont_y $up_x[1] $up_cont_y $up_x[1] $up_y ".
       #     "Z"
       # };
        my $point = { 'd' => "M $up_x[0] $up_y L $up_x[0] $upY ".
            "C $up_x[0] $up_cont_y $down_x[0] $down_cont_y $down_x[0] $down_y L $down_x[0] $downY ".
            "H $down_x[1] L $down_x[1] $down_y ".
            "C $down_x[1] $down_cont_y $up_x[1] $up_cont_y $up_x[1] $upY L $up_x[1] $up_y ".
          "Z"
       };
	
        push @res, [$point, $$ref[0], $$ref[-1],$$ref[3]];
    }
    return (@res);
}


sub getGapPos
{
    my $file = shift;
    my $cutoff = shift;
    $cutoff||=5000;
    my %seq = &getSeq($file);
    my %pos;
    foreach my $chr (keys %seq)
    {
        my $chrseq = $seq{$chr};
        while( $chrseq=~/([nN]{1000,})/g)
        {
            my $len = length($1);
            my $end = pos($chrseq);
            my $start = $end-$len+1;
            push @{$pos{$chr}},[$start,$end];
        }
    }
    return (\%pos);
}


sub getSeq
{
    my $file=shift;
    my %chr;
    $/=">";
    open FA,$file;
    <FA>;
    while(<FA>)
    {
        chomp;
        my($head,$seq)=split/\n+/,$_,2;
        my $id =(split/\s+/,$head)[0];
        next if $id=~/dom/ || $id=~/old/ || $id=~/onti/ || $id=~/chrC/;
        $seq=~s/\n+//g;
        $seq=~s/>$//;
        $chr{$id}=$seq;
    }
    close FA;
    $/="\n";
    return (%chr);
}

