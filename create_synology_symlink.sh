#!/usr/bin/env bash
if [ ! -L ~/SynologyDrive ]; then
  ln -sf /run/media/luix/fb4aa704-4e49-4e13-b1c3-6bb57030fa5e/ ~/SynologyDrive
fi
