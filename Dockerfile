FROM python:3.11

# Install system dependencies
RUN apt-get update -y && apt-get install -y python3-pybind11 libsphinxbase-dev libpocketsphinx-dev ffmpeg libavdevice-dev

# Set uid & gid in order to deal with permissions of mounted volumes
ARG USER_ID=1000
ARG GROUP_ID=1000

RUN addgroup --gid $GROUP_ID user
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user

# Create workdir and set permissions
RUN mkdir /opt/subsync && chown -R $USER_ID:$GROUP_ID /opt/subsync
WORKDIR /opt/subsync

USER user

# Download latest version
RUN git clone https://github.com/sc0ty/subsync.git .

# Copy default config
RUN cp subsync/config.py.template subsync/config.py

# Install requirements and build
RUN pip install .



ENTRYPOINT ["/opt/subsync/bin/subsync" , "--cli"]

WORKDIR /working