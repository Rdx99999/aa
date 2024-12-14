FROM kylemanna/openvpn

# Set working directory for OpenVPN
WORKDIR /etc/openvpn

# Generate OpenVPN Server configuration (replace 'your-render-domain-name' with your Render's domain)
RUN ovpn_genconfig -u udp://your-render-domain-name

# Initialize PKI (Public Key Infrastructure) for OpenVPN
RUN ovpn_initpki

# Copy the generated client configuration file to the container
# Make sure you generate this locally (see steps below)
COPY client1.ovpn /etc/openvpn/client1.ovpn

# Expose OpenVPN UDP port
EXPOSE 1194/udp

# Start OpenVPN server
CMD ["openvpn", "--config", "/etc/openvpn/frps.ini"]
