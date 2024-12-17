FROM rockylinux:8.7

RUN dnf install -y glib2-2.56.4-158.el8_6.1 gcc make openssl-devel cargo rust which perl

# Copy your project files into the container
COPY . /app
WORKDIR /app

# Set the script as executable
RUN chmod +x build.sh

# Run the script
RUN /bin/bash build.sh

# Create a directory to hold the output file
RUN mkdir -p /output

# Move your file to the /output directory
RUN mv /app/target/release/trak_aprinter /output/

# Specify the command for the container (for manual inspection or extraction)
CMD ["true"]
