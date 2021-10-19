FROM alpine:latest AS build
RUN apk --no-cache add openjdk8 && apk --no-cache add gradle
RUN gradle build

FROM alpine:latest AS work
RUN mkdir /app
WORKDIR /app
COPY --from=build /dev-school-app/build/libs/dev-school-app-1.0-SNAPSHOT.jar app.jar
RUN apk --no-cache add openjdk11
RUN java -jar dev-school-app/build/libs/dev-school-app-1.0-SNAPSHOT.jar
