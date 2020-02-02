#!/bin/bash

echo $WORKSPACE

touch output.txt
echo "The current directory=$WORKSPACE" >> output.txt
echo "This should be output of tag potato" >> output.txt

exit 0

