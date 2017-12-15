#!/bin/bash

set -e

echo -e "\n##############################"
echo      "# Running mdl (markdownlint) #"
echo      "##############################"
# disable the line-length check
mdl -r ~MD013 .

exit 0 # don't die based on markdownlint
