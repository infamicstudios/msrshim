#!/bin/bash

# Request a file to write results to
echo logfile name? \(should be a .txt\): 
read logFile

###
##   Query and identify available MSRs
###

RANGELOW=0
RANGEHIGH=8192 # Covers entire range of possible x86 MSRs

for ((i=RANGELOW;i<=RANGEHIGH;i++)) do 
    i=$(printf "%#x\n" $i) # Convert to hex
    regresult=`rdmsr ${i} 2> /dev/null` # Filter unadressable MSRs
   if [ -z "$regresult" ]; then
       :
   else # Register is available
       echo ${regresult}
   fi
done



