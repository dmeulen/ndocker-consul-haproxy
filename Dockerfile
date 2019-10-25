FROM alpine:3.9

MAINTAINER Danny van der Meulen <danny@cb750k6.nl>

ENV \
  ALPINE_MIRROR="nl.alpinelinux.org" \
  ALPINE_VERSION="v3.9" \
  CONSUL_TEMPLATE_VERSION=0.22.0 \
  APK_ADD="" \
  APK_ADD_PERM="curl busybox haproxy" \
  AMAVIS_MYDOMAIN=\
  AMAVIS_MYHOSTNAME=\
  AMAVIS_ACL=\
  POSTFIX_RETURN=

EXPOSE 10024

WORKDIR /

RUN \
  echo "http://${ALPINE_MIRROR}/alpine/${ALPINE_VERSION}/main" > /etc/apk/repositories && \
  echo "http://${ALPINE_MIRROR}/alpine/${ALPINE_VERSION}/community" >> /etc/apk/repositories && \
  apk --no-cache update && \
  apk --no-cache upgrade && \
  apk --no-cache add ${APK_ADD} ${APK_ADD_PERM} && \
  curl -L https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip -o /tmp/consul-template.zip && \
  unzip /tmp/consul-template.zip -d /usr/bin && \
  # Do stuff here
  apk --purge del ${APK_ADD} && \
  rm -rf \
    /tmp/* \
    /var/cache/apk/*

CMD ["/usr/bin/consul-template"]
