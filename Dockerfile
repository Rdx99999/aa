# Use the dorowu/ubuntu-desktop-lxde-vnc image
FROM dorowu/ubuntu-desktop-lxde-vnc

# Expose the port for VNC
EXPOSE 6070

# Command to run the image
CMD ["bash"]
