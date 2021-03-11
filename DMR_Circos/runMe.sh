#!/bin/bash  

set -o nounset                              # Treat unset variables as an error

/data02/public_software/circos-0.66/bin/circos -conf circos.conf -param image/radius=1000p >log 2>errlog


