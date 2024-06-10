# Stage 1: Build the Java application
FROM maven:3.6.3-jdk-11 AS build

# Set the working directory
WORKDIR /app

# Copy the pom.xml and install dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy the rest of the application source code
COPY src ./src

# Build the application
RUN mvn clean package

# Stage 2: Create the final image to run the application
FROM openjdk:11-jre-slim

# Set the working directory
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/helloworld-0.0.1-SNAPSHOT.jar app.jar

# Expose the application port
EXPOSE 8080

# Run the JAR file
ENTRYPOINT ["java", "-jar", "app.jar"]
