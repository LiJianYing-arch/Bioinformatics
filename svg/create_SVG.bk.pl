#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: create_SVG.pl
#
#        USAGE: ./create_SVG.pl  
#
#  DESCRIPTION: create the SVG picture of the synteny block
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: cotton-genome (cg), 
# ORGANIZATION: Group of Cotton Genetic Improvement
#      VERSION: 1.0
#      CREATED: 03/17/2014 09:45:25 PM
#     REVISION: ---
#===============================================================================

use utf8 ;
use strict ;
use warnings ;
use Data::Dumper ;
use Getopt::Long ;
use SVG ;
use Config::Tiny ;

push (@INC,`pwd`) ;

use Gene qw(convert_coord);

#### usage #####################

my $USAGE = <<USAGE;
create_SVG.pl -f config_file -g genelist_file
	-b Gbgff3_file -r Grgff3_file
	-a GbTEgff3_file -c GrTEgff3_file
	> out.svg 2>errlog &
USAGE


#----------------------------------------------------------------
my $config = "" ;
my $genelist = ""; # three columns (At Gr Dt)
my $Gbgenegff3 = ""; # the gene model gff3 file of Gb
my $Grgenegff3 = ""; # the gene model gff3 file of Gr

my $GbTEgff3 = "" ;
my $GrTEgff3 = "" ;

my $ok = GetOptions("f|config=s" => \$config,
					"g|genelist=s" => \$genelist,
					"b|gbgff3=s" => \$Gbgenegff3,
				    "r|grgff3=s" => \$Grgenegff3,
					"a|GbTEgff3=s" => \$GbTEgff3,
					"c|GrTEgff3=s" => \$GrTEgff3
					)
					;
unless ($config && $genelist && $Gbgenegff3 && $Grgenegff3 && $GbTEgff3 && $GrTEgff3)
{
	die "$USAGE\n" ;
}

my $Config = Config::Tiny->new() ;
$Config = Config::Tiny->read("$config") ;

#-------------------------------------------------------------------------
my $SVG_HEIGHT = $Config->{"GLOBAL"}->{"SVG_HEIGHT"}; #px the height of svg
my $SVG_WIDTH = $Config->{"GLOBAL"}->{"SVG_WIDTH"}; #px the width of svg
my $GENE_HEIGHT = $Config->{"GLOBAL"}->{"GENE_HEIGHT"}; #px the height of each gene
my $TE_HEIGHT = $Config->{"GLOBAL"}->{"TE_HEIGHT"}; #px the height of TE
my $At_LEFT_OFFSET = $Config->{"GLOBAL"}->{"At_LEFT_OFFSET"}; #px the left offset of At
my $Dt_LEFT_OFFSET = $Config->{"GLOBAL"}->{"Dt_LEFT_OFFSET"}; #px the left offset of Dt
my $Gr_LEFT_OFFSET = $Config->{"GLOBAL"}->{"Gr_LEFT_OFFSET"}; #px the left offset of Gr
my $HEIGHT_OFFSET = $Config->{"GLOBAL"}->{"HEIGHT_OFFSET"}; #px the height offset of each species
my $SCALE = $Config->{"GLOBAL"}->{"SCALE"}; # the scale of the real length(bp) to the SVG width
my $FLANK = $Config->{"GLOBAL"}->{"FLANK"}; # expand
my $BAR_HEIGHT = $GENE_HEIGHT / 3 ;
#--------------------------------------------------------------------------

#------------------------------------------------------
my $g_max_length = 0 ;
my $g_At_stroke_color = $Config->{"GLOBAL"}->{"At_stroke_color"};
my $g_At_fill_color = $Config->{"GLOBAL"}->{"At_fill_color"};
my $g_Dt_stroke_color = $Config->{"GLOBAL"}->{"Dt_stroke_color"};
my $g_Dt_fill_color = $Config->{"GLOBAL"}->{"Dt_fill_color"};
my $g_Gr_stroke_color = $Config->{"GLOBAL"}->{"Gr_stroke_color"};
my $g_Gr_fill_color = $Config->{"GLOBAL"}->{"Gr_fill_color"};
my $g_TE_stroke_color = $Config->{"GLOBAL"}->{"TE_stroke_color"};
my $g_TE_fill_color = $Config->{"GLOBAL"}->{"TE_fill_color"};
my $g_TE_fill_opacity = $Config->{"GLOBAL"}->{"TE_fill_opacity"};
my $g_link_fill_color = $Config->{"GLOBAL"}->{"link_fill_color"};
my $g_link_fill_opacity = $Config->{"GLOBAL"}->{"link_fill_opacity"};
#------------------------------------------------------

open GENE, "<$genelist" or die "$!\n" ;
my @regions = () ;
my @tmp = () ;
my @orders = () ; #store the order of each species
my $hash_gene = {} ;
my %hash_species_start_end = () ;
my @names = () ;
my $t = () ;

while ( <GENE> )
{
	chomp;
	if(/^#/)
	{
		s/^#//g ;
		@orders = split ;
		$t = <GENE> ;
		chomp $t ;
		@names = split(/\s+/,$t) ;
		next ;
	}else
	{
		@regions = split ;
		@tmp = split(/\s+/,`grep mRNA.*$regions[0] $Gbgenegff3`) ;
		if ( scalar @tmp <= 1 )
		{
			die "not grep the cood of $regions[0]\n" ;
		}
		push(@{$hash_gene->{"At"}},[$tmp[3],$tmp[4]]) ;
		@tmp = split(/\s+/,`grep mRNA.*$regions[1] $Grgenegff3`) ;
		if ( scalar @tmp <= 1 )
		{
			die "not grep the cood of $regions[1]\n" ;
		}
		push(@{$hash_gene->{"Gr"}},[$tmp[3],$tmp[4]]) ;
		@tmp = split(/\s+/,`grep mRNA.*$regions[2] $Gbgenegff3`) ;
		if ( scalar @tmp <= 1 )
		{
			die "not grep the cood of $regions[2]\n" ;
		}
		push(@{$hash_gene->{"Dt"}},[$tmp[3],$tmp[4]]) ;
	}
}

my $At_length = &get_Length($hash_gene->{"At"},$orders[0]) ;
my $Gr_length = &get_Length($hash_gene->{"Gr"},$orders[1]) ;
my $Dt_length = &get_Length($hash_gene->{"Dt"},$orders[2]) ;

$g_max_length = &max_length($At_length,$Dt_length,$Gr_length) ;

my $At_start_end = &get_species_start_end($hash_gene->{"At"},$orders[0]) ;
my $Gr_start_end = &get_species_start_end($hash_gene->{"Gr"},$orders[1]) ;
my $Dt_start_end = &get_species_start_end($hash_gene->{"Dt"},$orders[2]) ;


#-----------------
#
#SVG object
#
#-----------------

my $hash_gene_coord = () ;
my $svgobj = SVG->new(width => $SVG_WIDTH, height => $SVG_HEIGHT) ;
my $Atsvggroup = $svgobj->group(id => "At",
				 style => { stroke=>$g_At_stroke_color, fill=>$g_At_fill_color }
				 )
				 ;

my $geneobj = "" ;
$Atsvggroup->rectangle(
	x => $At_LEFT_OFFSET,
	y => $GENE_HEIGHT + $GENE_HEIGHT / 2 - $BAR_HEIGHT / 2,
	width => ($At_start_end->{"end"} - $At_start_end->{"start"}) 
			 * ($SVG_WIDTH / $g_max_length * $SCALE),
	height => $BAR_HEIGHT
);

foreach my $gene (@{$hash_gene->{"At"}})
{
	$geneobj = Gene::new(
		"species" => "At",
		"offset" => $At_LEFT_OFFSET,
		"scale" => $SVG_WIDTH / $g_max_length * $SCALE,
		"HEIGHT" => $GENE_HEIGHT,
		"START" => $At_start_end->{"start"},
		"END" => $At_start_end->{"end"},
		"y" => $GENE_HEIGHT,
		"start" => $gene->[0],
		"end" => $gene->[1],
		"order" => $orders[0]
	);
	push(@{$hash_gene_coord->{"At"}},[$geneobj->convert_coord()->{"x"},
									  $geneobj->convert_coord()->{"y"},
									  $geneobj->convert_coord()->{"w"},
									  $geneobj->convert_coord()->{"h"}])
								  ;

	$Atsvggroup->rectangle(
		x => $geneobj->convert_coord()->{"x"},
		y => $geneobj->convert_coord()->{"y"},
		width => $geneobj->convert_coord()->{"w"},
		height => $geneobj->convert_coord()->{"h"},
		rx => 5,
		ry => 5
	) ;
}

my $Grsvggroup = $svgobj->group(id => "Gr",
	             style => { stroke=>$g_Gr_stroke_color, fill=>$g_Gr_fill_color }
				 )
				 ;

$Grsvggroup->rectangle(
	    x => $Gr_LEFT_OFFSET,
		y => $GENE_HEIGHT + $HEIGHT_OFFSET + $GENE_HEIGHT / 2 - $BAR_HEIGHT / 2,
		width => ($Gr_start_end->{"end"} - $Gr_start_end->{"start"})
				 * ($SVG_WIDTH / $g_max_length * $SCALE),
		height => $BAR_HEIGHT
		);


foreach my $gene (@{$hash_gene->{"Gr"}})
{
	$geneobj = Gene::new(
		"species" => "Gr",
		"offset" => $Gr_LEFT_OFFSET,
		"scale" => $SVG_WIDTH / $g_max_length * $SCALE,
		"HEIGHT" => $GENE_HEIGHT ,
		"START" => $Gr_start_end->{"start"},
		"END" => $Gr_start_end->{"end"},
		"y" => $GENE_HEIGHT + $HEIGHT_OFFSET,
		"start" => $gene->[0],
		"end" => $gene->[1],
		"order" => $orders[1]
	);
	push(@{$hash_gene_coord->{"Gr"}},[$geneobj->convert_coord()->{"x"},
		                              $geneobj->convert_coord()->{"y"},
									  $geneobj->convert_coord()->{"w"},
									  $geneobj->convert_coord()->{"h"}])
																													                                    ;
	$Grsvggroup->rectangle(
		x => $geneobj->convert_coord()->{"x"},
		y => $geneobj->convert_coord()->{"y"},
		width => $geneobj->convert_coord()->{"w"},
		height => $geneobj->convert_coord()->{"h"},
		rx => 5,
		ry => 5
	);
}

my $Dtsvggroup = $svgobj->group(id => "Dt",
				 style => { stroke=>$g_Dt_stroke_color, fill=>$g_Dt_fill_color }
			 )
			 ;

$Dtsvggroup->rectangle(
	    x => $Dt_LEFT_OFFSET,
		y => $GENE_HEIGHT + 2 * $HEIGHT_OFFSET + $GENE_HEIGHT / 2 - $BAR_HEIGHT / 2,
		width => ($Dt_start_end->{"end"} - $Dt_start_end->{"start"})
				 * ($SVG_WIDTH / $g_max_length * $SCALE),
		height => $BAR_HEIGHT
		);

foreach my $gene (@{$hash_gene->{"Dt"}})
{
	$geneobj = Gene::new(
		"species" => "Dt",
		"offset" => $Dt_LEFT_OFFSET,
		"scale" => $SVG_WIDTH / $g_max_length * $SCALE,
		"HEIGHT" => $GENE_HEIGHT ,
		"START" => $Dt_start_end->{"start"},
		"END" => $Dt_start_end->{"end"},
		"y" => $GENE_HEIGHT + 2 * $HEIGHT_OFFSET,
		"start" => $gene->[0],
		"end" => $gene->[1],
		"order" => $orders[2]
	);
	push(@{$hash_gene_coord->{"Dt"}},[$geneobj->convert_coord()->{"x"},
		                              $geneobj->convert_coord()->{"y"},
									  $geneobj->convert_coord()->{"w"},
									  $geneobj->convert_coord()->{"h"}])
																													                                    ;
	$Dtsvggroup->rectangle(
		x => $geneobj->convert_coord()->{"x"},
		y => $geneobj->convert_coord()->{"y"},
		width => $geneobj->convert_coord()->{"w"},
		height => $geneobj->convert_coord()->{"h"},
		rx => 5,
		ry => 5
	);
}

######print the link#####
my $xcoords = [] ;
my $ycoords = [] ;
my $points = "" ;
for (my $i = 0; $i <= scalar @{$hash_gene_coord->{"At"}} + 0 - 1; $i++)
{
	$xcoords = [] ;
	$ycoords = [] ;
	$xcoords->[0] = $hash_gene_coord->{'At'}->[$i]->[0] ;
	$ycoords->[0] = $hash_gene_coord->{'At'}->[$i]->[1] + $hash_gene_coord->{'At'}->[$i]->[3] ;
	$xcoords->[1] = $hash_gene_coord->{'Gr'}->[$i]->[0] ;
	$ycoords->[1] = $hash_gene_coord->{'Gr'}->[$i]->[1] ;
	$xcoords->[2] = ($hash_gene_coord->{'Gr'}->[$i]->[0] + $hash_gene_coord->{'Gr'}->[$i]->[2]) ;
	$ycoords->[2] = $hash_gene_coord->{'Gr'}->[$i]->[1] ;
	$xcoords->[3] = ($hash_gene_coord->{'At'}->[$i]->[0] + $hash_gene_coord->{'At'}->[$i]->[2]) ;
	$ycoords->[3] = $hash_gene_coord->{'At'}->[$i]->[1] + $hash_gene_coord->{'At'}->[$i]->[3];
	$points = $svgobj->get_path(
			  x => $xcoords,
		  	  y => $ycoords,
		  	  -type => 'path',
			  -closed => 'true'
		      );
	$svgobj->path(%$points,
		          style => {'fill' => "$g_link_fill_color", 'fill-opacity' => $g_link_fill_opacity}
		         ) ;
	
	$xcoords = [] ;
	$ycoords = [] ;
	$xcoords->[0] = $hash_gene_coord->{'Gr'}->[$i]->[0] ;
	$ycoords->[0] = $hash_gene_coord->{'Gr'}->[$i]->[1] + $hash_gene_coord->{'Gr'}->[$i]->[3] ;
	$xcoords->[1] = $hash_gene_coord->{'Dt'}->[$i]->[0] ;
	$ycoords->[1] = $hash_gene_coord->{'Dt'}->[$i]->[1] ;
	$xcoords->[2] = ($hash_gene_coord->{'Dt'}->[$i]->[0] + $hash_gene_coord->{'Dt'}->[$i]->[2]) ;
	$ycoords->[2] = $hash_gene_coord->{'Dt'}->[$i]->[1] ;
	$xcoords->[3] = ($hash_gene_coord->{'Gr'}->[$i]->[0] + $hash_gene_coord->{'Gr'}->[$i]->[2]) ;
	$ycoords->[3] = $hash_gene_coord->{'Gr'}->[$i]->[1] + $hash_gene_coord->{'Gr'}->[$i]->[3];

	$points = $svgobj->get_path(
			    x => $xcoords,
			    y => $ycoords,
			    -type => 'path',
			    -closed => 'true'
			    );
	$svgobj->path(%$points,
			    style => {'fill' => "$g_link_fill_color", 'fill-opacity' => $g_link_fill_opacity}
			    );
}




####draw TE tracks#####
#
######################

##At TE################
@tmp = `grep -w $names[0] $GbTEgff3` ;
my $AtTEsvggroup = $svgobj->group(id => "AtTE",
	    style => { 'fill' =>$g_TE_fill_color,'fill-opacity' => $g_TE_fill_opacity }
		)
		;
my @tmp1 = () ;
for my $te_element(@tmp)
{
	chomp $te_element ;
	@tmp1 = split(/\s+/,$te_element) ;
	next if (!($tmp1[3] >= $At_start_end->{"start"} && $tmp1[4] <= $At_start_end->{"end"})) ;
	$geneobj = Gene::new(
				"species" => "At",
				"offset" => $At_LEFT_OFFSET,
				"scale" => $SVG_WIDTH / $g_max_length * $SCALE,
				"HEIGHT" => $TE_HEIGHT ,
				"START" => $At_start_end->{"start"},
				"END" => $At_start_end->{"end"},
				"y" => $GENE_HEIGHT,
				"start" => $tmp1[3],
				"end" => $tmp1[4],
				"order" => $orders[0]
			   );

	$AtTEsvggroup->rectangle(
		        x => $geneobj->convert_coord()->{"x"},
				y => $geneobj->convert_coord()->{"y"} - ($TE_HEIGHT-$GENE_HEIGHT) / 2,
				width => $geneobj->convert_coord()->{"w"},
				height => $geneobj->convert_coord()->{"h"}
				);
}

###Gr TE#####
@tmp = `grep -w $names[1] $GrTEgff3` ;
my $GrTEsvggroup = $svgobj->group(id => "GrTE",
	style => { 'fill' => $g_TE_fill_color, 'fill-opacity' => $g_TE_fill_opacity }
	)
	;

for my $te_element(@tmp)
{
	chomp $te_element ;
	@tmp1 = split(/\s+/,$te_element) ;
	next if (!($tmp1[3] >= $Gr_start_end->{"start"} && $tmp1[4] <= $Gr_start_end->{"end"})) ;
	$geneobj = Gene::new(
		"species" => "Gr",
		"offset" => $Gr_LEFT_OFFSET,
		"scale" => $SVG_WIDTH / $g_max_length * $SCALE,
		"HEIGHT" => $TE_HEIGHT ,
		"START" => $Gr_start_end->{"start"},
		"END" => $Gr_start_end->{"end"},
		"y" => $GENE_HEIGHT + $HEIGHT_OFFSET,
		"start" => $tmp1[3],
		"end" => $tmp1[4],
		"order" => $orders[1]
	);
	$GrTEsvggroup->rectangle(
		x => $geneobj->convert_coord()->{"x"},
		y => $geneobj->convert_coord()->{"y"} - ($TE_HEIGHT-$GENE_HEIGHT) / 2,
		width => $geneobj->convert_coord()->{"w"},
		height => $geneobj->convert_coord()->{"h"}
	);
}


#Dt TE track#####
@tmp = `grep -w $names[2] $GbTEgff3` ;
my $DtTEsvggroup = $svgobj->group(id => "DtTE",
	    style => { 'fill' => $g_TE_fill_color, 'fill-opacity' => $g_TE_fill_opacity }
		    )
	;

for my $te_element(@tmp)
{
	chomp $te_element ;
	@tmp1 = split(/\s+/,$te_element) ;
	next if (!($tmp1[3] >= $Dt_start_end->{"start"} && $tmp1[4] <= $Dt_start_end->{"end"})) ;
	$geneobj = Gene::new(
		"species" => "Dt",
		"offset" => $Dt_LEFT_OFFSET,
		"scale" => $SVG_WIDTH / $g_max_length * $SCALE,
		"HEIGHT" => $TE_HEIGHT ,
		"START" => $Dt_start_end->{"start"},
		"END" => $Dt_start_end->{"end"},
		"y" => $GENE_HEIGHT + 2 * $HEIGHT_OFFSET,
		"start" => $tmp1[3],
		"end" => $tmp1[4],
		"order" => $orders[2]
	);

	$DtTEsvggroup->rectangle(
		x => $geneobj->convert_coord()->{"x"},
		y => $geneobj->convert_coord()->{"y"} - ($TE_HEIGHT-$GENE_HEIGHT) / 2,
		width => $geneobj->convert_coord()->{"w"},
		height => $geneobj->convert_coord()->{"h"}
	);
}

print $svgobj->xmlify();





#--------------------------------------------------------
# function sets
#--------------------------------------------------------


sub get_Length
{
	my ($refarray, $order) = @_ ;
	my $length = 0 ;
	if ($order eq "+1")
	{
		$length = $refarray->[@{$refarray} + 0 -1]->[1] - $refarray->[0]->[0] ;
	}else
	{
		$length = $refarray->[0]->[1] - $refarray->[@{$refarray} + 0 -1]->[0] ;
	}
	return $length ;
}

sub max_length
{
	my @array = @_ ;
	my $max = -1000000 ;
	foreach (@array)
	{
		if ($_ >= $max)
		{
			$max = $_ ;
		}
	}
	return $max + 2 * $FLANK ;
}

sub get_species_start_end
{
	my ($refarray, $order) = @_ ;
	my $start_end = {} ;
	if ($order eq "+1")
	{
		$start_end->{"start"} = $refarray->[0]->[0] - $FLANK ;
		$start_end->{'end'} = $refarray->[@{$refarray} + 0 -1]->[1] + $FLANK ;
	}else
	{
		$start_end->{"end"} = $refarray->[0]->[1] + $FLANK ;
		$start_end->{'start'} = $refarray->[@{$refarray} + 0 -1]->[0] - $FLANK ;
	}
	return $start_end ;
}

