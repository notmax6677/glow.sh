# glow.sh

This script is meant to bridge the distance between the complicated usage of changing screen brightnesses with xrandr, and monkeys who can't be bothered to remember all of the documentation just to turn their screen down 5 brightness units.

## Prerequisites
* xrandr
* tput
* bc
* grep
* awk

## Installation

You can install this file by either downloading it, curling it, or fetching it with wget.

wget
```sh
wget https://raw.githubusercontent.com/notmax6677/glow.sh/main/glow.sh
```

curl
```sh
curl https://raw.githubusercontent.com/notmax6677/glow.sh/main/glow.sh -o glow.sh
```

Afterwards just make it executable
```sh
chmod +x glow.sh
```

## Usage

#### Get function
The `get` function is a very versatile tool, offering up to TWO FUNCTIONS with different capabilities.

The first one, `get device`, will show all active screen devices attached to your computer.
```sh
./glow get device
```
or
```sh
./glow get dev
```

The second function, being equally useful, is `get brightness`, it will fetch the brightness of a given screen.
```sh
./glow get brightness DEVICE_NAME
```
or
```sh
./glow get br DEVICE_NAME
```
The brightness will be shown from a scale of 0 to 1.0.
0 = 0%
1.0 = 100%

#### Set function
The set function seems pretty self-explanatory, it just sets the brightness of a given device.

Use it like this
```sh
./glow set DEVICE_NAME BRIGHTNESS
```
Please remember that `BRIGHTNESS` is on a scale from 0 to 1.

That's all there is to it, enjoy :)
