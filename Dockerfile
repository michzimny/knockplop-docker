FROM node:9

RUN npm install -g bower \
    && npm install -g node-inspect

RUN wget https://github.com/kelseyhightower/confd/releases/download/v0.14.0/confd-0.14.0-linux-amd64 -O /bin/confd \
    && chmod +x /bin/confd

ENV KNOCKPLOP_GIT_REPO=https://github.com/up2university/knockplop.git
# from this repo, this git-ref selects branch up2u as of 15th Jan 2018
ENV KNOCKPLOP_GIT_REF=a87fa7941a43510cc0164a355e26c690f48f0451

WORKDIR /opt/knockplop

RUN git clone $KNOCKPLOP_GIT_REPO . \
    && git checkout $KNOCKPLOP_GIT_REF

RUN npm install \
    && bower install --allow-root

RUN cp client-config.js.dist client-config.js

COPY self-signed-certs/cert.pem /etc/self-signed-certs/
COPY self-signed-certs/key.pem /etc/self-signed-certs/
COPY entrypoint.sh .
COPY confd /etc/confd

ENTRYPOINT ["./entrypoint.sh"]
CMD ["node", "server.js"]

