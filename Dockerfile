FROM alpine:latest AS build
RUN mkdir /app
WORKDIR /app
RUN apk --no-cache add openjdk11 && apk --no-cache add gradle
RUN gardle build

FROM alpine:latest AS work
RUN mkdir /app
WORKDIR /app
COPY --from=build /app/dev-school-app/build/libs .
RUn java -jar dev-school-app-1.0-SNAPSHOT.jar