# Use the official Golang image to create a build artifact.
# This is based on Debian and sets the GOPATH to /go.
FROM golang:1.21-alpine as builder

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy everything from the current directory to the PWD(Present Working Directory) inside the container
COPY . .

# Build the Go app
RUN go build -o myserver .

# Start a new stage from scratch
FROM debian:buster-slim

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy the Pre-built binary file from the previous stage
COPY --from=builder /app/myserver .

# Expose port 8080 to the outside world
EXPOSE 8080

# Command to run the executable
CMD ["./myserver"]
