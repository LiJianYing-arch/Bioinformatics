#!/bin/bash  

set -o nounset                              # Treat unset variables as an error

perl ~/software/circos-0.68-pre1/bin/circos --conf circos.conf -param image/radius=1000p >log 2>errlog


