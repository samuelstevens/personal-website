#!/bin/bash

input=personal-website
output=samuelstevens.github.io
root=~/Development

serve $root/$output &



source build.sh $input $output $root

clean
full_convert_md
build

echo "Going to $(pbpaste)..."
open $(pbpaste)

fd . --type file | entr ./build.sh $input $output $root
