#!/usr/bin/perl;
use LWP::Simple;
use HTML::TreeBuilder;
use HTML::FormatText;

$URL=get("http://cpst.hzau.edu.cn/Index.html");
$Format=HTML::FormatText->new;
$Tree=HTML::TreeBuilder->new;
$Tree->parse($URL);
$pa=$Format->format($Tree);
print "$pa";