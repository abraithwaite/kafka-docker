FROM java:8-jre-alpine

RUN apk add --update curl docker jq coreutils ca-certificates gnupg && update-ca-certificates

ENV KAFKA_VERSION="0.9.0.1" SCALA_VERSION="2.11" PGP_KEYID="E0A61EEA"
ADD download-kafka.sh /tmp/download-kafka.sh
RUN /tmp/download-kafka.sh

VOLUME ["/kafka"]

ENV KAFKA_HOME /usr/local/kafka_${SCALA_VERSION}-${KAFKA_VERSION}
ADD start-kafka.sh /usr/bin/start-kafka.sh
ADD broker-list.sh /usr/bin/broker-list.sh
ADD create-topics.sh /usr/bin/create-topics.sh

# Use "exec" form so that it runs as PID 1 (useful for graceful shutdown)
CMD ["start-kafka.sh"]
