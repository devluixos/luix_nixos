#!/usr/bin/env bash
set -e  # Exit on error

# Get the current directory
DIR=$(pwd)

# Create the output directory
mkdir -p "$DIR/transcoded"

# Transcode the videos
for i in "$DIR"/*.mp4; do
    ffmpeg -i "$i" -vcodec mjpeg -q:v 2 -acodec pcm_s16be -q:a 0 -f mov "$DIR/transcoded/${i##*/}"
done