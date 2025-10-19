#!/bin/zsh
# @gilbertca - 2025-08-30
# A simple utility to screenshot and send an area of the screen to an LLM powered by ollama.

# Screenshot directory:
ssdir=$HOME/screenshots
vared -p "Directory for screenshots (default: $ssdir)> " ssdir
# Screenshot filename:
filename=$(date +'%Y-%m-%d-%I:%M.png')
vared -p "Screenshot filename (default: $filename)" -c filename
# Model name in ollama:
model=""
vared -p "Model to use (default: )> " -c model
# URL to the server:
url="http://localhost/11434/api/chat"
vared -p "URL to query (default: $url)> " -c url
# User message:
message="Extract all text from this image. Do not provide extraneous info or intros."
vared -p "User message to LLM (default: $message)> " -c message
# Sleep time:
sleep_time=0
vared -p "Seconds to sleep before screenshot (default: $sleep_time)> " -c sleep_time
sleep $sleep_time

echo $ssdir

# `grimshot` saves an area as a file
# `base` grabs PNG data from stdin, writes encoded base64 to stdout
# `aijsonify.py` grabs the image from stdin and the cmdline args, writes the response from the API to stdout
#grimshot save area $ssdir/$filename&&cat $ssdir/$filename|base64 -w 0 -|python3 aijsonify.py --url=$url --model=$model --message=$message>>$model.out
