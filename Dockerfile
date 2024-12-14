FROM alpine:latest

# Install necessary packages
RUN apk add --no-cache wget bash

# Download and extract FRP
RUN wget https://github.com/fatedier/frp/releases/download/v0.42.0/frp_0.42.0_linux_amd64.tar.gz && \
    tar -zxvf frp_0.42.0_linux_amd64.tar.gz && \
    rm -f frp_0.42.0_linux_amd64.tar.gz

# Set working directory
WORKDIR /frp_0.42.0_linux_amd64

# Create frps.ini with debug logging
RUN echo "[common]" > frps.ini && \
    echo "bind_port = 7000" >> frps.ini && \
    echo "log_file = ./frps.log" >> frps.ini && \
    echo "log_level = debug" >> frps.ini

# Expose port 7000 for FRP
EXPOSE 7000

# Start the FRP server
CMD ./frps -c frps.ini
