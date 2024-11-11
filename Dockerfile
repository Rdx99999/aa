# Use a Python base image
FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && \
    apt-get install -y curl ffmpeg && \
    apt-get clean

# Run the curl command to install sshx
RUN curl -sSf https://sshx.io/get | sh -s run

# Set the working directory
WORKDIR /app

# Copy your project files into the container
COPY . /app

# Install Python dependencies using Poetry (if you use Poetry)
RUN pip install --no-cache-dir -r requirements.txt

# Expose the necessary port (if you're running a web service)
EXPOSE 5000

# Command to run your Python application
CMD ["python", "app.py"]
