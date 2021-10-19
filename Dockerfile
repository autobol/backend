FROM alpine:latest AS build
RUN mkdir /app
WORKDIR /app
RUN apk --no-cache add openjdk11 && apk --no-cache add gradle
RUN gradle build
RUN ls

#FROM alpine:latest AS work
#RUN mkdir /app
#WORKDIR /app
#COPY --from=build /app/dev-school-app/build/libs/dev-school-app-1.0-SNAPSHOT.jar app.jar
#RUN apk --no-cache add openjdk11
#RUN java -jar dev-school-app/build/libs/dev-school-app-1.0-SNAPSHOT.jar
