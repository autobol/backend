FROM alpine:latest AS build

RUN apk --no-cache add openjdk8 &&\
 # apk --no-cache add gradle &&\
  mkdir -p /app
WORKDIR /app
COPY . /app
# RUN ["gradle", "wrapper", "--gradle-version", "6.6.1"]
RUN ["ls"]
RUN ["./app/gradlew.bat", "build"]


FROM alpine:latest AS work

RUN apk --no-cache add openjdk8 &&\
 mkdir /app
WORKDIR /app
COPY --from=build app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
