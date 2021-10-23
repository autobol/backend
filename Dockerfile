FROM alpine:latest AS build

ENV GRADLE_VERSION = '6.6.1'
ENV JAVA_VERSION = '8'

RUN apk --no-cache add openjdk$JAVA_VERSION &&\
 apk --no-cache add gradle &&\
  mkdir -p /app
WORKDIR /app
COPY . /app
RUN gradle wrapper --gradle-version $GRADLE_VERSION &&\
 chmod +x gradlew
RUN ["./gradlew", "build"]


FROM openjdk:$JAVA_VERSION AS work

RUN mkdir /app
WORKDIR /app
COPY --from=build app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
