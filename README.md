# Subsync Docker image
Based on [sc0ty/subsync](https://github.com/sc0ty/subsync). Compiled without GUI support.

Available on [Docker Hub](https://hub.docker.com/r/davvos11/subsync)

## Usage:
### Basic usage:
```bash
docker run davvos11/subsync [any-arguments-to-pass-to-subsync]
```

Usage of SubSync is documented [here](https://github.com/sc0ty/subsync/wiki/Command-line-options).

### Files
The working directory in the container is `/working` so it is easiest to mount your files there, like so:
```bash
docker run -u 1000 -v /path/to/files:/working davvos11/subsync [any-arguments-to-pass-to-subsync]
```
(don't forget to specify the correct uid with `-u uid` so that the container has write permissions to the output file)

### Example
To sync the subtitles of a specific file:
```bash
docker run -u 1000 -v /mnt/data2/Series/Brooklyn\ Nine-Nine/Season\ 3/:/working \
    davvos11/subsync sync \
    --ref Brooklyn\ Nine-Nine\ -\ S03E09\ -\ The\ Swedes\ Bluray-1080p.mp4 \
    --sub Brooklyn\ Nine-Nine\ -\ S03E09\ -\ The\ Swedes\ Bluray-1080p.en.srt \
    --out Brooklyn\ Nine-Nine\ -\ S03E09\ -\ The\ Swedes\ Bluray-1080p-new.en.srt
```