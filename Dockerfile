FROM alpine:latest AS build

RUN apk --no-cache add openjdk8 &&\
 apk --no-cache add gradle &&\
  mkdir -p /app
WORKDIR /app
COPY . /app
RUN ["gradle", "build"]


FROM alpine:latest AS work

RUN mkdir /app
WORKDIR /app
COPY --from=build app/build/libs/dev-school-app-1.0-SNAPSHOT.jar app.jar
RUN apk --no-cache add openjdk8
ENTRYPOINT ["java", "-jar", "app.jar"]
