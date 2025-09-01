#!/bin/zsh
# @gilbertca - 2025-08-30
# A simple utility to screenshot and send an area of the screen to an LLM powered by ollama.

# Model name in ollama:
vared -p "Model to use> " -c model
# URL to the server:
vared -p "URL to query> " -c url
# User message:
vared -p "User message to LLM> " -c message
# Sleep time:
vared -p "Seconds to sleep before screenshot (0 for instant)> " -c sleep_time
sleep $sleep_time

# `slurp` grabs the screen area, writes to stdout
# `grim` grabs screen area from stdin, writes the PNG data to stdout
# `base` grabs PNG data from stdin, writes encoded base64 to stdout
# `aijsonify.py` grabs the image from stdin and the cmdline args, writes the response from the API to stdout
slurp|grim -t png -l 9 -g - -|base64 -w 0 -|python3 aijsonify.py --url=$url --model=$model --message=$message>>$model.out
