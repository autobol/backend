FROM alpine:latest AS build

RUN apk --no-cache add openjdk11 && apk --no-cache add gradle && mkdir app/
WORKDIR app/
COPY .
RUN ["gradle", "build"]


FROM alpine:latest AS work

RUN mkdir /app
WORKDIR /app
COPY --from=build app/dev-school-app/build/libs/dev-school-app-1.0-SNAPSHOT.jar app.jar
RUN apk --no-cache add openjdk11
ENTRYPOINT ["java", "-jar", "app.jar"]
