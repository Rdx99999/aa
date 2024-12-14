FROM alpine:latest

# Install wget and frp
RUN apk add --no-cache wget
RUN wget https://github.com/fatedier/frp/releases/download/v0.42.0/frp_0.42.0_linux_amd64.tar.gz
RUN tar -zxvf frp_0.42.0_linux_amd64.tar.gz && rm -f frp_0.42.0_linux_amd64.tar.gz
WORKDIR frp_0.42.0_linux_amd64

# Create frps.ini (FRP Server config file)
RUN echo '[common]' > frps.ini && \
    echo 'bind_port = 7000' >> frps.ini

# Expose necessary ports (the FRP server port)
EXPOSE 7000

# Run the FRP server
CMD ./frps -c frps.ini
