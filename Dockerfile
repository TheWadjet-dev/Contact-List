# Use an official Go image as the build environment
FROM golang:1.20 AS builder

# Set the working directory
WORKDIR /app

# Copy the go.mod and go.sum files and download dependencies
COPY main.go .

# Copy the source code and templates
COPY . .

# Build the application with CGO disabled for compatibility with Alpine
RUN go build -o world-clock

# Use a minimal image for running the application
FROM alpine:latest

# Install ca-certificates (required for Go web servers)
RUN apk add --no-cache ca-certificates

# Set the working directory
WORKDIR /app

# Copy the binary and templates from the builder image
COPY --from=builder /app/world-clock-go /app/world-clock .
COPY --from=builder /app/templates /app/templates .

# Expose port 8080
EXPOSE 8080

# Run the application
CMD ["./world-clock"]
