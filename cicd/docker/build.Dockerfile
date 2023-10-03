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
RUN ./mvnw sass:update-stylesheets
RUN ./mvnw package -Dquarkus.profile=${CONFIG_ENV}

#FINAL IMAGE
FROM openjdk:11-jdk-slim
LABEL maintainer=<"marsel.mori@adiwisista.com">
RUN apt-get update; apt-get install -y fontconfig libfreetype6
WORKDIR /danaiid
WORKDIR /deployments/template \
ENV TZ="Asia/Jakarta"
COPY --from=builder /app/build/target/quarkus-app /danaiid/quarkus-app
EXPOSE 8080

ENTRYPOINT [ "java", "-jar", "/danaiid/quarkus-app/quarkus-run.jar" ]