# knockplop-docker
Dockerized Knockplop - meeting webservice, based on WebRTC technology

This project dockerizes https://github.com/up2university/knockplop/

This Docker image is automatically built at https://hub.docker.com/r/michzimny/knockplop/

## Run

By default the container exposes HTTPS with self-signed certificates, and tries to use [the TURN service from GÉANT](https://turn.geant.org/). The only parameter to provide is a REST API token for the TURN service.

The service can be simply run by:

```
docker run -d -p 80:80 -p 443:443 -e REST_API_KEY=XXXYYYZZZ michzimny/knockplop
```

## Build

To build the image on your own, one can adjust KNOCKPLOP_GIT_REF variable in Dockerfile to a desired reference (commit SHA-1 or branch name).

The image can be built with for instance:

```
docker build -t michzimny/knockplop .
```

## TLS certificates

For production usage, one might want to adjust TLS (HTTPS) certificates.

The following environmental variables need to be set to indicate PEM paths of a certificate:

* SSL_KEY - the certificate private key
* SSL_CERT - the actual certificate
* SSL_CA - the certificate's chain (optionally)

For instance using [certbot-auto](https://certbot.eff.org/docs/install.html#certbot-auto), assuming the certbot output directory is at ./certs, one can provide the directory as a Docker volume and set the variables in env-file:

```
docker run -d \
    -p 80:80 \
    -p 443:443 \
    --env-file env \
    -v $(pwd)/certs:/etc/certs:ro \
    --restart=unless-stopped \
    michzimny/knockplop
```

with "env" file containing:

```
REST_API_KEY=XXXYYYZZZ
SSL_KEY=/etc/certs/live/example.com/privkey.pem
SSL_CERT=/etc/certs/live/example.com/cert.pem
SSL_CA=/etc/certs/live/example.com/chain.pem
```

## TURN connection

By default, GÉANT TURN service is in use. The default API URL is the following one, with the value of $REST_API_KEY at its end:

```
https://api.turn.geant.org/turn?uri_schema=turn&transport=tcp&ip_ver=ipv4%2Cipv6&servercount=1&api_key=XXXYYYZZZ
```

The URL can be adjusted by setting environmental variable REST_API_URL. Its value must be a valid JS expression. The default value is:

```
REST_API_URI='https://api.turn.geant.org/turn?uri_schema=turn&transport=tcp&ip_ver=ipv4%2Cipv6&servercount=1&api_key='+config.REST_API_KEY
```
