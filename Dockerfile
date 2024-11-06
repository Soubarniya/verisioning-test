# Dockerfile

# First stage: Build the Go application with Go 1.23
FROM golang:1.23 AS builder
WORKDIR /app

# Copy go.mod to cache dependencies
COPY go.mod .
RUN go mod download

# Copy the source code
COPY . .

# Build the Go application
RUN go build -o go-api

# Second stage: Create a minimal image with the compiled binary
FROM gcr.io/distroless/base
COPY --from=builder /app/go-api /go-api

# Run the compiled Go binary
CMD ["/go-api"]
