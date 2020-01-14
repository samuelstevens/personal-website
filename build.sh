#!/bin/bash

# nodemon --exec "./build.sh" . -e css,md,html

input=${1:-personal-website}
output=${2:-samuelstevens.github.io}
root=${3:-~/Development}
input_dir=${root}/${input}
output_dir=${root}/${output}

shopt -s nullglob

convert_md () {
  for md in ${input_dir}/**/*.md ${input_dir}/*.md; do
    if [[ $md != *README* ]]; then

      # echo $md | sed -e "s/$input/$output/g" | sed 's/md/html/g'

      dirname=$(echo $md | sed -e "s/$input/$output/g" | sed 's/md/html/g' | xargs dirname)
      mkdir -p $dirname

      pandoc --from markdown+backtick_code_blocks --to html5 -s --template=template.html --ascii $md > $(echo $md | sed -e "s/$input/$output/g" | sed 's/md/html/g')
    fi
  done
}

convert_html () {
  for html in ${input_dir}/**/*.html ${input_dir}/*.html; do
    if [[ $html != *template* ]]; then
      # echo $html | sed -e "s/$input/$output/g"
      cp $html $(echo $html | sed -e "s/$input/$output/g")
    fi
  done
}

copy_js () {
  for js in ${input_dir}/**/*.js; do
    cp $js $(echo $js | sed -e "s/$input/$output/g")
  done
}

build () {
  # minimizes the css files
  mkdir -p $output_dir/css
  for css_file in ${input_dir}/css/*.css; do
    cat $css_file | tr -d '\n' | sed -E 's/[[:space:]]+/ /g' > ${output_dir}/css/$(basename $css_file)
  done

  # gets the markdown and converts them to html
  convert_md

  # converts any custom html
  convert_html

  # copies js
  mkdir -p $output_dir/js
  copy_js

  # copies images
  mkdir -p $output_dir/images
  cp -r $input_dir/images/* $output_dir/images

  # copies my resume
  cp ~/Documents/Work/Sam\ Stevens\ Resume\ $(date +%Y).pdf ${output_dir}/resume.pdf

  cp ~/Development/airpods/dist/Airpods.dmg ${output_dir}/Airpods.dmg
}

build
