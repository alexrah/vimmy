#!/bin/bash

 
if [ -z "$1" ]; then
        echo
        echo usage: $0 network-interface
        echo
        echo e.g. $0 eth0
        echo
        exit
fi

IF=$1

while true
do
        R1=`cat /sys/class/net/$1/statistics/rx_bytes`
        T1=`cat /sys/class/net/$1/statistics/tx_bytes`
        sleep 1
        R2=`cat /sys/class/net/$1/statistics/rx_bytes`
        T2=`cat /sys/class/net/$1/statistics/tx_bytes`
        TBPS=`expr $T2 - $T1`
        RBPS=`expr $R2 - $R1`
        TKBPS=`printf %.2f "$((10**9 * $TBPS / 1000000 * 8))e-9"`
        RKBPS=`printf %.2f "$((10**9 * $RBPS / 1000000 * 8))e-9"`
        echo "$1 - Upload: $TKBPS Mbit/s - Download: $RKBPS Mbit/s"
done
