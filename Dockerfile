# Use an official Go image as the build environment
FROM golang:1.20 AS builder

# Set the working directory
WORKDIR /app

# Copy go.mod and go.sum files
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy the main application code and templates
COPY main.go ./

# Build the application with CGO disabled for compatibility with Alpine
RUN CGO_ENABLED=0 GOOS=linux go build -o world-clock

# Use a minimal image for running the application
FROM alpine:latest

# Install ca-certificates (required for Go web servers)
RUN apk add --no-cache ca-certificates

# Set the working directory
WORKDIR /app

# Copy the binary and templates from the builder image
COPY --from=builder /app/world-clock /app/world-clock
COPY index.html .

# Expose port 8080
EXPOSE 8080

# Run the application
CMD ["./world-clock"]
