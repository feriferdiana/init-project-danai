FROM openjdk:11-jdk-slim AS builder
LABEL maintainer=<"marsel.mori@adiwisista.com">

WORKDIR /app/build
ENV TZ="Asia/Jakarta"
#Copy dependecies
COPY .mvn/ .mvn
COPY src/ ./src
COPY mvnw ./
COPY pom.xml ./
RUN chmod +x mvnw

#Build java
ARG CONFIG_ENV
RUN ./mvnw package -Dquarkus.profile=${CONFIG_ENV}

#FINAL IMAGE
FROM openjdk:11-jdk-slim
LABEL maintainer=<"marsel.mori@adiwisista.com">
WORKDIR /danaiid
ENV TZ="Asia/Jakarta"

COPY --from=builder /app/build/target/quarkus-app /danaiid/quarkus-app
WORKDIR /danaiid/peruri/sharefolder/
WORKDIR /danaiid/peruri/sharefolder/SIGNED
WORKDIR /danaiid/peruri/sharefolder/UNSIGNED
WORKDIR /danaiid/peruri/sharefolder/TEMP
WORKDIR /danaiid/peruri/sharefolder/STAMP
WORKDIR /danaiid/peruri


#RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
#Install curl
#RUN apt update
#RUN apt-get -y install curl
#RUN apt install curl -y

#install sudo
#RUN install sudo
#RUN su -
#RUN apt-get install sudo -y

#install docker
#RUN curl -fsSL https://get.docker.com -o get-docker.sh
#RUN sudo sh get-docker.sh
#install docker-compose
#RUN sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)"  -o /usr/local/bin/docker-compose
#RUN sudo mv /usr/local/bin/docker-compose /usr/bin/docker-compose
#RUN sudo chmod +x /usr/bin/docker-compose

ARG APP_PORT
EXPOSE ${APP_PORT}

ENTRYPOINT [ "java", "-jar", "/danaiid/quarkus-app/quarkus-run.jar" ]