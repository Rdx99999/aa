# Use the official Firefox image from jlesage
FROM jlesage/firefox

# Expose the necessary port (5800 for VNC access)
EXPOSE 5800

# Set the working directory
WORKDIR /app

# Optionally, you can add any custom configuration or additional files here
