# Use an official image as the base image (e.g., Ubuntu)
FROM ubuntu:20.04

# Update the package repository and install curl
RUN apt-get update && apt-get install -y curl

# Run the command you provided and log the output to a file
RUN curl -sSf https://sshx.io/get | tee /var/log/sshx_install.log | bash

# Expose any required ports if needed
EXPOSE 80

# Specify the default command to run
CMD ["bash"]
