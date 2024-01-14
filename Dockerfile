FROM debian:10 AS build

RUN apt-get update && apt-get -y install maven

WORKDIR /opt/AM

COPY pom.xml /opt/AM/
RUN mvn dependency:resolve
COPY src /opt/AM/src/
RUN mvn package


FROM openjdk:11-jdk

EXPOSE 8080

WORKDIR /opt/AM

ENV DB_HOST=mysql

COPY --from=build /opt/AM/target/AM-1.0.jar AM.jar

CMD [ "java", "-Xmn256m", "-Xmx768m", "-jar", "AM.jar" ]
