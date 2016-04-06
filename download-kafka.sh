#!/bin/sh

set -xe

file="kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz"
url="https://www-us.apache.org/dist/kafka/${KAFKA_VERSION}/${file}"
cd /tmp
curl -LO "${url}"
curl -LO "${url}".asc
gpg --keyserver pgpkeys.mit.edu --recv-key "${PGP_KEYID}"
gpg --verify ${file}.asc ${file}
tar xfz ${file} -C /usr/local
rm /tmp/${file} /tmp/${file}.asc
