#!/bin/bash

# Remux MKV Files to support Audio for LG C1 using FFMPEG

# List all episodes
episodes_list=`ls ./*.mkv`
for episode in $episodes_list
do
  episode_name=`basename ${episode}`
  converted_episode_name="converted_${episode_name}"
  
  # Convert https://www.reddit.com/r/LGOLED/comments/safu66/comment/httevw3/?utm_source=share&utm_medium=web2x&context=3
  ffmpeg -i $episode_name -map 0:v -map 0:a:0 -map 0:a -map 0:s -c:v copy -c:a copy -c:s copy -c:a:0 ac3 -b:a:0 640k $converted_episode_name
done