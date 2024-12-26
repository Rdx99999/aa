# Start from the base Firefox image
FROM jlesage/firefox

# Expose port 5800 for VNC access
EXPOSE 5800

# Set the working directory
WORKDIR /app

# Install necessary packages to modify VNC server settings
RUN apt-get update && apt-get install -y \
    x11vnc \
    && rm -rf /var/lib/apt/lists/*

# Custom script to configure x11vnc to listen on all IPs
RUN echo '#!/bin/bash\n\
x11vnc -forever -usepw -display :0 -listen 0.0.0.0' > /start_vnc.sh \
    && chmod +x /start_vnc.sh

# Set the entrypoint to start VNC server
ENTRYPOINT ["/start_vnc.sh"]
