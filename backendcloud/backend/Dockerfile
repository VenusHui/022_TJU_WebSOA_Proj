FROM openjdk:18-jdk-alpine
VOLUME /tmp
ADD 022_TJU_WebSOA_Proj/backendcloud/backend/backend.jar app.jar
EXPOSE 8000
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
