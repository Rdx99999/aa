# Use the official Ubuntu image as a base
FROM ubuntu:latest

# Set the working directory to /app
WORKDIR /app

# Install OpenVPN and other required packages
RUN apt update && apt install -y openvpn easy-rsa

# Generate server certificates and keys
RUN easy-rsa build-server-full server

# Create the OpenVPN server configuration file
COPY server.conf /etc/openvpn/

# Expose the OpenVPN port
EXPOSE 1194/udp

# Run the OpenVPN server when the container starts
CMD ["openvpn", "--config", "/etc/openvpn/server.conf"]
