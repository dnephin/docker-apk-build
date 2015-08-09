#!/bin/sh

set -e

cp /home/abuild/*.pub /etc/apk/keys/
apk update
exec sh
