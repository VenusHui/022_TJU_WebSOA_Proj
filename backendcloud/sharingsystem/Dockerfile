FROM openjdk:18-jdk-alpine
VOLUME /tmp
ADD backendcloud/sharingsystem/target/sharingsystem-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8002
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
