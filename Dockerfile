FROM openjdk:8-jdk-alpine
RUN useradd -m java_user 
EXPOSE 8080
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} /home/java_user/app.jar
USER java_user
ENTRYPOINT ["java","-jar","/app.jar"]