FROM openjdk:8-jdk-alpine
RUN adduser -D java_user 
WORKDIR /home/java_user
ARG JAR_FILE=target/*.jar
ADD ${JAR_FILE} app.jar
USER java_user
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
