FROM python:3.11

WORKDIR /opt/subsync

# Download latest version
RUN git clone https://github.com/sc0ty/subsync.git .

# Install system dependencies
RUN apt-get update -y && apt-get install -y python3-pybind11 libsphinxbase-dev libpocketsphinx-dev ffmpeg libavdevice-dev

# Copy default config
RUN cp subsync/config.py.template subsync/config.py

# Install requirements and build
RUN pip install .

ENTRYPOINT ["/opt/subsync/bin/subsync" , "--cli"]

WORKDIR /working