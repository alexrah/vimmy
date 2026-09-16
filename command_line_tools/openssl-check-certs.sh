#!/bin/bash

if [ -n "$1" ]
then

  printf "Public public & private key hashes matching...\n"
  if ! diff -q <(openssl x509 -noout -pubkey -in $1 | openssl md5) <(openssl pkey -in $1 -pubout | openssl md5)
  then
    echo "ERROR: certificate and private key do not match in $1" >&2
    exit 1
  fi

  printf "Checking full chain...\n"
  openssl crl2pkcs7 -nocrl -certfile $1 | openssl pkcs7 -print_certs -text -noout | bat
else
  echo "Please provide path to *.pem file"

fi
