#!/bin/sh
#
# Run the first time to setup keys
#

set -e

sudo chown packager:packager ~/.abuild/
abuild-keygen -a -i
