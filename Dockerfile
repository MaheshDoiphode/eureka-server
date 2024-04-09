# Stage 1: Build the application
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Copy the local code to the container
COPY . .

# Build the application
RUN mvn package -DskipTests

# Stage 2: Create the runtime image
FROM eclipse-temurin:17.0.10_7-jre-alpine

# Expose the port the app runs on
EXPOSE 8080

# Copy the JAR from the build stage to the runtime stage
COPY --from=build target/*.jar app.jar

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
