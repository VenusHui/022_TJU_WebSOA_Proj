FROM openjdk:18-jdk-alpine
VOLUME /tmp
ADD target/backend.jar app.jar
EXPOSE 8000
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
