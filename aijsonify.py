"""
Reads a base64-encoded image from stdin, calls the RESTful API defined by the arguments

aijsonify.py
@gilbertca - 2025-08-30
"""
from argparse import ArgumentParser
from json import dumps
from sys import stdin

from requests import post

# TODO: error codes
def aijsonify(model: str, url: str, message: str, stream: bool=False) -> None:
    """`aijsonify` creates a JSON object, sends a request to the **url**, and prints the output to `stdout`.

    Arguments:
        **model**: the name of the model
        **url**: the url of the API
        **message**: the 'user' message to the model

    Returns:
        None
    """
    # Read from stdin to get the b64 image:
    b64image_list = stdin.readlines()

    # Format and send request:
    request_data = {
        "model": model,
        "messages": [
            {
                "role": "user",
                "content": message,
                "images": b64image_list
            }
        ],
        "stream": stream
    }
    response = post(url=url, json=request_data)

    # Handle output:
    print(response.json())

if __name__=="__main__":
    parser = ArgumentParser(description=__doc__)
    parser.add_argument("--url", type=str, required=True)
    parser.add_argument("--model", type=str, required=True)
    parser.add_argument("--message", type=str, required=True)
    args = vars(parser.parse_args()) # Convert `Namespace` to `dict`

    aijsonify(**args)
