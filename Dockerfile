# Use an official Rust image as the build environment
FROM rust:1.71 AS builder

# Set the working directory
WORKDIR /app

# Copy the Cargo.toml and Cargo.lock to cache dependencies
COPY Cargo.toml .

# Create a dummy main file to cache dependencies
RUN mkdir src && echo "fn main() {}" > src/main.rs

# Build the dependencies only
RUN cargo build --release

# Now copy the actual source code
COPY src ./src

# Build the application with the actual code
RUN cargo build --release

# Use a minimal image for running the application
FROM debian:buster-slim

# Set the working directory
WORKDIR /app

# Copy the binary from the builder image
COPY --from=builder /app/target/release/world-clock /app/world-clock

# Expose port 8080
EXPOSE 8080

# Run the application
CMD ["./world-clock"]
