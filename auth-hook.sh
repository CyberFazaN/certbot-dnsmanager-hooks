#!/bin/bash

_dir="$(dirname "$0")"
source "$_dir/config.sh"

# Strip only the top domain to get the zone id
PLID=$(echo "$CERTBOT_DOMAIN" | awk -F. '{print $(NF-1)"."$NF}')

# Get subdomain
subdomain=${CERTBOT_DOMAIN%"$PLID"}
subdomain=${subdomain%.}  # Remove trailing dot, if present

# Determine TXT record name
if [[ -n "$subdomain" ]]; then
  CREATE_DOMAIN="_acme-challenge.$subdomain"
else
  CREATE_DOMAIN="_acme-challenge"
fi

# Save created record ELID to cleanup it later
echo "$CREATE_DOMAIN.$PLID.%20TXT%20%20$CERTBOT_VALIDATION" >> $_dir/elid.txt

OUT=$(curl -s -X GET "https://$API_HOST/dnsmgr?out=json&authinfo=$API_USERNAME:$API_PASSWORD&func=domain.record.edit&name=$CREATE_DOMAIN&plid=$PLID&rtype=txt&ttl=3600&value=$CERTBOT_VALIDATION&sok=ok")

sleep 5
echo OK
