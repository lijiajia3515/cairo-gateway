FROM openjdk:11-jre-slim

MAINTAINER lijiajia

RUN sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list; \
    sed -i 's/security.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list; \
    apt clean -y; \
    apt update -y; \
    apt upgrade -y; \
    apt install curl wget jq -y

ADD build/libs/app.jar /hfhk/gateway/app.jar

ENV TZ Asia/Shanghai
ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8
ENV LC_ALL C.UTF-8

ENV SPRING_PROFILES_ACTIVE docker


WORKDIR /hfhk/gateway
VOLUME /hfhk/gateway/logs

ENTRYPOINT java -jar app.jar

EXPOSE 80
HEALTHCHECK --start-period=10s --interval=30s --timeout=30s --retries=10 \
            CMD curl --silent --fail --request GET http://localhost/actuator/health | jq --exit-status '.status == "UP"' || exit 1
