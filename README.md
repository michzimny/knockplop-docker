# knockplop-docker
Dockerized Knockplop - meeting webservice (based on WebRTC technology

This project dockerizes https://github.com/so010/knockplop/

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

## Customization

TODO
