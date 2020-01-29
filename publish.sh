#!/usr/bin/env bash

input=${1:-personal-website}
output=${2:-samuelstevens.github.io}
root=${3:-~/Development}
input_dir=${root}/${input}
output_dir=${root}/${output}

commit_message=${1:-"updated file(s) at $(date)"}
echo $commit_message

publish () {
  git add .
  git commit -m "$1"
  git push
}


# python3 writing.py


# for writing in ${input_dir}/writing/*.md; do
#   aspell check $writing
# done

./build.sh


cd $output_dir
publish $commit_message

