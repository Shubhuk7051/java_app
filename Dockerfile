# Start from an official Maven image that includes JDK
FROM maven:3.8.7-eclipse-temurin-17 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the Maven project files into the container
COPY pom.xml /app/
COPY src /app/src

# Build the Maven project
RUN mvn clean package

# Second stage to create a leaner image for the application
FROM eclipse-temurin:17-jre

# Set the working directory in the new container
WORKDIR /app

# Copy the jar from the build stage
COPY --from=build /app/target/*.jar /app/app.jar

# Expose the application's port (adjust the port as necessary)
EXPOSE 8080

# Command to run the jar file
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
