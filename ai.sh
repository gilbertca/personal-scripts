#!/bin/zsh
# @gilbertca - 2025-08-30
# A simple utility to screenshot and send an area of the screen to an LLM powered by ollama.
images=$(slurp|grim -t png -l 0 -g - -|base64 -w 0 -)
vared -p "Model to user> " -c model
vared -p "URL to query> " -c url
vared -p "User message to LLM> " -c message
curl --url ${url} -X POST --json "{
	\"model\": \"${model}\",
	\"stream\": false,
	\"messages\": [
	{\"role\": \"user\", \"content\":\"${message}\", \"images\": [\"${images}\"]}
	]
}"
