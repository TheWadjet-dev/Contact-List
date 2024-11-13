# Use an official Go image as the build environment
FROM golang:1.20 AS builder

# Set the working directory
WORKDIR /app

# Copy the go.mod and go.sum files and download dependencies
COPY main.go .

# Build the application with CGO disabled for compatibility with Alpine
RUN CGO_ENABLED=0 GOOS=linux go build -o world-clock main.go

# Use a minimal image for running the application
FROM alpine:latest

# Install ca-certificates (required for Go web servers)
RUN apk add --no-cache ca-certificates

# Set the working directory
WORKDIR /app

# Copy the binary and templates from the builder image
COPY --from=builder /app/blackjack .
COPY index.html .

# Expose port 8080
EXPOSE 8010

# Run the application
CMD ["./world-clock"]
