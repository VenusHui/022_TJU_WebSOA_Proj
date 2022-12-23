FROM openjdk:18-jdk-alpine
VOLUME /tmp
ADD backendcloud/ticketsystem/target/ticketsystem-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8001
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
