#!/bin/bash

# Request a file to write results to
echo logfile name? \(should be a .txt\): 
read logFile

###
##   Query and identify available MSRs
###

RANGELOW=0
RANGEHIGH=8192 # Covers entire range of possible x86 MSRs
ALLOWEDMSRS="allowlist.txt"

echo Generating MSRS for range ${RANGELOW} to ${RANGEHIGH} and printing results to ${logFile}

for ((i=RANGELOW;i<=RANGEHIGH;i++)) do 
    addr=$(printf "%#x\n" $i) # Convert to hex
    regresult=`rdmsr ${addr} 2> /dev/null` # Filter unadressable MSRs
   if [ -z "$regresult" ]; then
       echo \{NULL, false, false\}, >> ${logFile}
   else # Register is available
       addr=$(printf "%#010x" $i) # Convert to the format of hex in the allowfile
       # Search for the MSR in the allowfile this can be made arbitrarily more complicated through regex patterns.
       if grep -q ${addr} ${ALLOWEDMSRS}; then
          echo \{0x${regresult}ULL, true, true\}, >> ${logFile}
       else
          echo \{0x${regresult}ULL, true, false\}, >> ${logFile}
       fi
    fi
done



