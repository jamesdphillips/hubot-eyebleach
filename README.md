# hubot-eyebleach

A Hubot script for displaying eye cleansing images

    hubot eyebleach me # displays random image

### Settings

    HUBOT_EYEBLEACH_NSFW=TRUE # Pulls from r/gentlemanboners; r/cute by default
    HUBOT_EYEBLEACH_RANGE=week # Defaults to month

### Installation

1. Edit `package.json` and add `hubot-eyebleach` to the `dependencies` section. It should look something like this:

        "dependencies": {
          "hubot-eyebleach": ">= 0.0.1",
          ...
        }
2. Add "hubot-eyebleach" to your `external-scripts.json`. It should look something like this:

    ["hubot-eyebleach"]

