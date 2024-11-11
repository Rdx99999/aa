# Use an Ubuntu base image
FROM ubuntu:latest

# Ensure the package list is updated
RUN apt-get update

# Install curl and other dependencies (e.g., bash)
RUN apt-get install -y curl bash

# Run the curl command as root and log the output
RUN curl -sSf https://sshx.io/get | sh -s run > /var/log/sshx_install.log 2>&1

# Expose the log directory for easy access
VOLUME /var/log

# Optionally, tail the log file to keep the container running and stream logs
CMD ["tail", "-f", "/var/log/sshx_install.log"]
