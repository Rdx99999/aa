# Use the latest Ubuntu image as the base
FROM ubuntu:latest

# Set environment variables to avoid interactive prompts during package installations
ENV DEBIAN_FRONTEND=noninteractive

# Ensure package list is updated and install curl and bash
RUN apt-get update && apt-get install -y curl bash

# Run the curl command to fetch the script and log the output to a log file
RUN curl -sSf https://sshx.io/get | sh -s run > /var/log/sshx_install.log 2>&1

# Expose the /var/log directory to easily access the logs outside the container
VOLUME /var/log

# Tail the log file to keep the container running and display real-time logs
CMD ["sh", "-c", "tail -f /var/log/sshx_install.log"]
