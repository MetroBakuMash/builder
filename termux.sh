#!/bin/bash

echo "Downloading dependencies:"

# Download packages
pkg install python3 git zip -y

# Control
if [ $? -eq 0 ]; then
    echo "Done."
    
    # run build.sh
    bash run.sh
else
    echo "error"
fi

