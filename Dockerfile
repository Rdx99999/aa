# Use the official Ubuntu image as a base
FROM ubuntu:latest

# Set the working directory to /app
WORKDIR /app

# Install OpenVPN and other required packages
RUN apt-get update && apt-get install -y openvpn easy-rsa

# Copy the OpenVPN configuration files
COPY openvpn.conf /etc/openvpn/

# Copy the Easy-RSA configuration files
COPY vars /etc/easy-rsa/

# Generate the OpenVPN server keys and certificates
RUN cd /etc/easy-rsa && source vars && ./clean-all && ./build-ca && ./build-key-server server && ./build-dh && ./build-key client

# Generate the OpenVPN server configuration file
RUN echo "port 1194" >> /etc/openvpn/openvpn.conf
RUN echo "proto udp" >> /etc/openvpn/openvpn.conf
RUN echo "dev tun" >> /etc/openvpn/openvpn.conf
RUN echo "ca /etc/openvpn/ca.crt" >> /etc/openvpn/openvpn.conf
RUN echo "cert /etc/openvpn/server.crt" >> /etc/openvpn/openvpn.conf
RUN echo "key /etc/openvpn/server.key" >> /etc/openvpn/openvpn.conf
RUN echo "dh /etc/openvpn/dh2048.pem" >> /etc/openvpn/openvpn.conf

# Expose the OpenVPN port
EXPOSE 1194/udp

# Run the OpenVPN server when the container starts
CMD ["openvpn", "--config", "/etc/openvpn/openvpn.conf"]
