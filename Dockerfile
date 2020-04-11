FROM node:11.5-alpine

# labels
LABEL maintainer="nohitme@gmail.com"

# variables
ENV HUGO_VERSION=0.67.1

# install hugo
RUN set -x && \
  apk add --update --upgrade --no-cache wget ca-certificates && \
  # make sure we have up-to-date certificates
  update-ca-certificates && \
  cd /tmp &&\
  wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz -O hugo.tar.gz && \
  tar xzf hugo.tar.gz && \
  mv hugo /usr/bin/hugo && \
  rm -r * && \
  # don't delete ca-certificates pacakge here since it remove all certs too
  apk del --purge wget && \
  # install firebase dependencies
  # use --unsafe-perm to solve this issue: https://github.com/firebase/firebase-tools/issues/372
  npm install -g firebase-tools@latest --unsafe-perm
  npm install -g firebase-admin@latest firebase-functions@latest
  npm install -g firebase-functions-test@latest eslint@5.12.0 eslint-plugin-promise@4.0.1 --dev
  # install dependencies for firebase functions simple webserver
  npm install -g basic-auth-connect@1.0.0 express@4.17.1