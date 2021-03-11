#!/usr/bin/perl -w
use strict ;
use SVG ;

my $file = shift ;
my $base = shift ;

my $svg = SVG->new(width=>200, height=>100);

my $startX = 5 ;
my $startY = "" ;
my $width = "" ;
my $height = "" ;

open IN,"<",$file ;
while (<IN>){
    chomp ;
    my @regions = split ;
    if ($regions[0] ne "BIN"){
        my $lens = $regions[3] - $regions[2] ;
        
        $width = $lens*$base ;
        $height = $regions[4]*2 ;
        $startY = 50 - $height ;

        my $yushu = $regions[1] % 2 ;
        if ($yushu == 1){
            $svg->rect(x => $startX, y => $startY, width => $width, height => $height, fill => "red") ;    
        }else{
            $svg->rect(x => $startX, y => $startY, width => $width, height => $height, fill => "blue") ;
        }
    }
    $startX = $startX + $width ;
}

my $out = $svg->xmlify;

open SVGFILE, ">temp.svg" ;
print SVGFILE $out ;


