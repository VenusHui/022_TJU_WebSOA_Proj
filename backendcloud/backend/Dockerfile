FROM openjdk:18-jdk-alpine
VOLUME /tmp
ADD backend.jar app.jar
EXPOSE 8000
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
# test CI/CD