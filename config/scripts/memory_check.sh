#!/bin/sh

MEM=$(free -m | grep Mem)
USEDMEM=$(echo $MEM | awk '{ printf $3 }')
TOTALMEM=$(echo $MEM | awk '{ printf $2 }')
PERCENTMEM=$(awk -v t1="$USEDMEM" -v t2="$TOTALMEM" 'BEGIN{printf "%.2f", t1/t2 * 100}')

echo "[INFO]     - Memory Usage: ${USEDMEM}/${TOTALMEM}MB  ${PERCENTMEM}%"

let WARNTHRESHOLD=80
let CRITTHRESHOLD=95
PERCENTMEMINT=$(awk -v t1="$USEDMEM" -v t2="$TOTALMEM" 'BEGIN{printf "%.0f", t1/t2 * 100}')

if [ "$PERCENTMEMINT" -ge "$CRITTHRESHOLD" ]
then
    echo "[CRITICAL] - Memory status : [ VERY LOW ]"
    exit 2
elif [ "$PERCENTMEMINT" -ge "$WARNTHRESHOLD" ]
then
    echo "[WARNING]  - Memory status : [ LOW ]"
    exit 1
fi

exit 0
