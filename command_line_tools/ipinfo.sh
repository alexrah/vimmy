#!/bin/sh
#
###
### For assistance, please visit forum.ipinfodb.com
#
# Created by Eric Gamache on 2009-05-26
# Version 1.0 by Eric Gamache -- 2009-06-04
# Version 1.1 updated by Marc-Andre Caron -- 2009-06-08 .. Added timezone
# Version 1.2 updated by Eric Gamache -- 2009-06-08 .. fix minors bugs.
# Version 1.3 updated by Marc-Andre Caron -- 2010-02-11 .. new timezone support, reduced complexity of the script.
#
# This script is provided "as is", with absolutely no warranty expressed or
# implied. Any use is at your own risk. Permission to use or copy this
# script for any purpose is hereby granted without fee. Permission to
# modify the code and to distribute modified code is granted, provided
# the above notices are retained, and a notice that the code was modified
# is included with the above copyright notice.
#
###############################################
####
####
####
# URL="http://api.ipinfodb.com/v3/ip-city/?key=eda56af160ebde0b764b1f4ef8ffe3f58bb55feecd65143aebc7bae1c4d1238d&ip="
URL="http://api.db-ip.com/addrinfo?api_key=6b09072e22548aef0d5c114467d5780fdbcc7ade&addr="
#
WGET_OPTION="=-b -q --wait=3 --waitretry=2 --random-wait --limit-rate=9578 "
WGET_AGENT="Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)"
#
ERROR=0
#
###############################################
if [ "$1" = "" ]; then
    ERROR=1
  else
      IP=$1
          HTTP_LINK_JSON="$URL""$IP"
        fi
##############
# I REMOVED ALL THE OPTIONS JUST TO ENTER "sh ipinfo.sh IP" WITH DEFAULT
# JSON OUTPUT AND TIMEZONE 
###############################################
 
###############################################
if [ "$ERROR" != "0" ]; then
    echo " "
      echo " usage : $0 IP TYPE TIMEZONE"
        echo " Where IP is the IP to check"
          echo " TYPE is the output type (xml|json)"
            echo " TIMEZONE is to show timezone data or not (false|true)"
              echo " Big thanks to the team of IPInfoDB (http://ipinfodb.com)"
                exit
              fi
###############################################
#
TST_wget=`wget > /dev/null 2>&1`
#
ErrorLevel=$?
#
if [ "$ErrorLevel" != 1 ] ; then
    echo " ----"
      echo " wget not found; please install it for proper operation."
        echo " ----"
          exit
        fi
###############################################
###############################################
#######
#######

    JSON_Info=`wget -qO- --user-agent="$WGET_AGENT" $HTTP_LINK_JSON"$TIMEZONE" 2>&1`
      echo "$JSON_Info"

