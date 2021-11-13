FROM autobol/image_for_build_back:latest AS build

ARG GRADLE_VERSION
ENV GRADLE_VERSION=$GRADLE_VERSION

WORKDIR /app
COPY . /app
RUN gradle wrapper --gradle-version $GRADLE_VERSION &&\
 chmod +x gradlew
RUN ["./gradlew", "build"]


FROM openjdk:8 AS work

ARG APP_VERSION
ENV APP_VERSION=$APP_VERSION

RUN mkdir /app
WORKDIR /app
COPY --from=build app/build/libs/*.jar app-${APP_VERSION}.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app-$APP_VERSION.jar"]
