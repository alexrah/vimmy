#!/bin/bash

# render a table of 256 colors
# ECMA-48 Select Graphic Rendition Escape Codes 
# @see https://strasis.com/documentation/limelight-xe/reference/ecma-48-sgr-codes

for i in {0..255}; do printf "\e[38;5;%dm %3d \e[0m" $i $i; [[ $((($i+1)%16)) == 0 ]] && echo; done
