perl ~/software/circos-0.68-pre1/bin/circos --conf circos.conf
convert -resize 100%x100% circos.svg circos.pdf
convert -resize 1024x1024 circos.svg circos1.pdf

convert foo.pdf pages-%03d.tiff
