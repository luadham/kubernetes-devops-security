# Stage 1: Build
FROM maven:3.8.6-openjdk-8 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Runtime
FROM openjdk:8-jdk-alpine
RUN adduser -D java_user 
WORKDIR /home/java_user
COPY --from=builder /app/target/*.jar app.jar
USER java_user
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
