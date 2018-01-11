#!/bin/bash
set -e

# set default config
export SSL_KEY=${SSL_KEY:-"/etc/self-signed-certs/key.pem"}
export SSL_CERT=${SSL_CERT:-"/etc/self-signed-certs/cert.pem"}
export REST_API_URI=${REST_API_URI:-"'https://api.turn.geant.org/turn?uri_schema=turn&transport=tcp&ip_ver=ipv4%2Cipv6&servercount=1&api_key='+config.REST_API_KEY"}

# run confd
confd -onetime -backend env

# run cmd
cd server
exec "$@"

