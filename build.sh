#!/bin/bash

set -eu


input=${1:-personal-website}
output=${2:-samuelstevens.github.io}
root=${3:-~/Development}
input_dir=${root}/${input}
output_dir=${root}/${output}


convert_single_md() {
  md=$1
  html=$(echo "$md" | sed -e "s/$input/$output/g" | sed "s/md/html/g")
  dirname=$(echo "$md" | sed -e "s/$input/$output/g" | sed 's/md/html/g' | xargs dirname)
  mkdir -p "$dirname"

  # check if the file has references and needs '--citeproc'
  if grep --quiet "^references:" "$md"; then
    citeproc="--citeproc"
  else
    citeproc=""
  fi

  pandoc --from markdown+backtick_code_blocks+link_attributes $citeproc --to html5 -s --template=template.html --ascii "$md" --out "$html"
}

full_convert_md () {
  for md in $(find ${input_dir} -name '*.md'); do
    if [[ $md != *README* && $md != *draft* ]]; then
      # echo $md | sed -e "s/$input/$output/g" | sed 's/md/html/g'
      convert_single_md "$md"
    fi
  done
}

latest_convert_md () {
  # finds the latest modified .md file.
  md=$(find ~/Development/personal-website -name '*.md' -exec ls -1t "{}" + | head -n 1)
  convert_single_md "$md"
}

convert_html () {
  for html in $(find ${input_dir} -name '*.html'); do
    if [[ $html != *template* ]]; then
      # echo $html | sed -e "s/$input/$output/g"
      cp "$html" $(echo $html | sed -e "s/$input/$output/g")
    fi
  done
}

copy_js () {
  for js in $(find ${input_dir} -name '*.js'); do
    cp "$js" $(echo "$js" | sed -e "s/$input/$output/g")
  done
}

build () {
  # minimizes the css files
  mkdir -p "$output_dir/css"
  for css_file in $(find ${input_dir} -name '*.css'); do
    cat $css_file | tr -d '\n' | sed -E 's/[[:space:]]+/ /g' > ${output_dir}/css/$(basename $css_file)
  done

  
  mkdir -p "$output_dir/writing"
  mkdir -p "$output_dir/projects"

  # gets the markdown and converts them to html
  latest_convert_md

  # converts any custom html
  convert_html

  # copies js
  mkdir -p "$output_dir/js"
  copy_js

  # copies images
  mkdir -p "$output_dir/images"
  cp -r "$input_dir"/images/* $output_dir/images

  # copies my resume (I use a CV now :cool:)
  # cp ~/Documents/Work/Sam\ Stevens\ Resume\ $(date +%Y).pdf ${output_dir}/resume.pdf

  cp ~/Documents/school/grad-school/cv/cv.pdf ${output_dir}/cv.pdf

  cp ~/Development/airpods/dist/Airpods.dmg ${output_dir}/Airpods.dmg

  cp CNAME ${output_dir}/CNAME

  # readinglist.json is my readinglist as an RSS feed
  if [[ -f "readinglist.json" ]]; then
    cp "readinglist.json" "${output_dir}/readinglist.json"
  fi
  # readinglist.xml is my readinglist as an RSS feed
  if [[ -f "readinglist.xml" ]]; then
    cp "readinglist.xml" "${output_dir}/readinglist.xml"
  fi

  echo "incrementally built at $(date)"
}

clean () {
  rm -r "${output_dir:?}"/* # shitty
}

build
