FROM node:9

RUN npm install -g bower \
    && npm install -g node-inspect

RUN wget https://github.com/kelseyhightower/confd/releases/download/v0.14.0/confd-0.14.0-linux-amd64 -O /bin/confd \
    && chmod +x /bin/confd

ENV KNOCKPLOP_GIT_REPO=https://github.com/so010/knockplop.git
# it selects branch develop-fix-rest-api as of 11th Jan 2018
ENV KNOCKPLOP_GIT_REF=de7233c0b83171d7036c962d119ef7d5c1547d3d

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

