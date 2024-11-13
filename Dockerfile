# Use an official Go image as the build environment
FROM golang:1.20 AS builder

# Set the working directory
WORKDIR /app

# Copy the go.mod and go.sum files and download dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the source code and templates
COPY . .

# Build the Go application
RUN go build -o world-clock-go

# Use a minimal image for running the application
FROM alpine:latest

# Set the working directory
WORKDIR /app

# Copy the binary and templates from the builder image
COPY --from=builder /app/world-clock-go /app/world-clock-go
COPY --from=builder /app/templates /app/templates

# Expose port 8080
EXPOSE 8080

# Run the application
CMD ["./world-clock-go"]
