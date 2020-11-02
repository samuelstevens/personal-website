#!/bin/bash

input=personal-website
output=samuelstevens.github.io
root=~/Development

node --version

sleep 0.5

serve $root/$output &

sleep 1

open $(pbpaste)

source build.sh $input $output $root

clean
full_convert_md
build

find . -type f | entr ./build.sh $input $output $root