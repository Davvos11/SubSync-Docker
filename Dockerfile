FROM python:3.11

# Install system dependencies
RUN apt-get update -y && apt-get install -y python3-pybind11 libsphinxbase-dev libpocketsphinx-dev ffmpeg libavdevice-dev

WORKDIR /opt/subsync

# Download latest version
RUN git clone https://github.com/sc0ty/subsync.git .

# Copy config file
COPY ./config.py subsync/config.py

# Create /config and set permissions
RUN mkdir /config && chmod 777 /config

# Install requirements and build
RUN pip install .



ENTRYPOINT ["/opt/subsync/bin/subsync" , "--cli"]

WORKDIR /working