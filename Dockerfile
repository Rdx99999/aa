# Use a Rust image to build the Bore CLI binary
FROM rust:latest as builder

# Install musl-gcc and related dependencies
RUN apt-get update && apt-get install -y \
    musl-tools build-essential

# Add the musl target for Rust
RUN rustup target add x86_64-unknown-linux-musl

# Build Bore CLI as a statically linked binary
RUN cargo install --target x86_64-unknown-linux-musl bore-cli

# Use a minimal runtime image
FROM alpine:latest

# Install glibc compatibility libraries for Alpine
RUN apk --no-cache add libc6-compat

# Copy the Bore CLI binary from the builder
COPY --from=builder /usr/local/cargo/bin/bore /usr/local/bin/bore

# Expose the server port
EXPOSE 7835

# Run the Bore server on Render
CMD ["bore", "server", "--min-port", "1024", "--max-port", "65535", "--secret", "my_secret", "--listen", "0.0.0.0:7835"]
