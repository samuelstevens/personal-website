#!/bin/bash

input=personal-website
output=samuelstevens.github.io
root=~/Development

serve $root/$output &

sleep 1

open $(pbpaste)

nodemon . -e js,sh,css,md,html --exec "./build.sh $input $output $root "
