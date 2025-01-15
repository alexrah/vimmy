#!/bin/bash

if [ -n "$1" ]
then
  openssl crl2pkcs7 -nocrl -certfile $1 | openssl pkcs7 -print_certs -text -noout
else
  echo "Please provide path to *.pem file"
fi
