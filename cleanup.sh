#!/bin/bash

_dir="$(dirname "$0")"
source "$_dir/config.sh"

if [[ -f "/tmp/certbot-dnsmanager-elids.txt" ]]; then
  while IFS= read -r ELID; do
    PLID=$(echo "$ELID" | sed -E 's/^.*\.([a-zA-Z0-9-]+\.[a-zA-Z]{2,})\.%20TXT.*/\1/')
    OUT=$(curl -s -X GET "https://$API_HOST/dnsmgr?out=json&authinfo=$API_USERNAME:$API_PASSWORD&func=domain.record.delete&plid=$PLID&elid=$ELID")
  done < "/tmp/certbot-dnsmanager-elids.txt"
  rm "/tmp/certbot-dnsmanager-elids.txt"
  echo OK
else
  echo Already OK. Skipping
fi
