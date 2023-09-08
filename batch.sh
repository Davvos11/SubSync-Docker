#!/bin/env bash

# Get arguments
while getopts ":u:d:sh" opt; do
  case $opt in
    u) uid="$OPTARG"
    ;;
    d) location="$OPTARG"
    ;;
    s) asroot=1
    ;;
    h) echo "-u [uid]               Run Docker container with user id uid"
       echo "-d [path to directory] Path to run SubSync (required)"
       echo "-s                     Run Docker with 'sudo'"
       exit 0
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    exit 1
    ;;
  esac
done

if [[ -z "$location" ]]; then
    echo "Please specify a directory with '-d /path/to/dir'"
    exit 1
fi
if [[ -z "$uid" ]]; then
    uid=$(id -u)
fi

path=$(realpath "$location")

commmand=""

if [[ -n $asroot ]]; then
    command+="sudo"
fi

command+=" docker run -u $uid"

command+=" -v \"$path\":/working davvos11/subsync --overwrite"

# Loop through all srt (subtitle) files
cd "$path"
for srt_file in *.srt; do
    [ -f "$srt_file" ] || break

    # Get name without .language.srt extention
    name="${srt_file%%.*}"
    # Get all files starting with this name
    # Then get the first file that is not an srt file (we assume this is the video file)
    for file in "$name"*; do
        if [[ "$file" != *.srt ]]; then
            vid_file="$file"
            break
        fi
    done
    
    # Add to the command
    command+="     sync --ref \"$vid_file\" --sub \"$srt_file\" --out \"$srt_file\""
done

echo "Running the following command:"
echo "$command"
echo

bash -c "$command"