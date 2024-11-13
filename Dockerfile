# Use an official OpenJDK runtime as a parent image
FROM openjdk:11-jdk

# Set the working directory inside the container
WORKDIR /app

# Copy the build.sbt and project files to the working directory
COPY build.sbt ./
COPY project ./project

# Copy the source code to the working directory
COPY src ./src

# Install sbt (Scala Build Tool)
RUN apt-get update && \
    apt-get install -y curl && \
    curl -L -o sbt.deb https://scala.jfrog.io/artifactory/debian/sbt-1.5.5.deb && \
    apt-get install -y ./sbt.deb && \
    sbt compile && \
    sbt stage

# Expose port 8080
EXPOSE 8080

# Define the command to run the app
CMD ["sbt", "run"]
