#!/bin/bash

# nodemon --exec "./build.sh" . -e css,md,html

input=personal-website
output=samuelstevens.github.io
root=~/Development
input_dir=${root}/${input}
output_dir=${root}/${output}

convert_md () {
  # echo "$1" | sed -e "s/$input/$output/g" | sed 's/md/html/g' 
  pandoc -s --template=template.html --ascii $1 > $(echo "$1" | sed -e "s/$input/$output/g" | sed 's/md/html/g')
}

# minimizes the css files
for css_file in ${input_dir}/css/*.css; do
  cat $css_file | tr -d '\n' | sed -E 's/[[:space:]]+/ /g' > ${output_dir}/css/$(basename $css_file)
done

# gets the markdown and converts them to html
for md in ${input_dir}/**/*.md; do
  convert_md $md
done

for md in ${input_dir}/*.md; do
  convert_md $md
done

# copies my resume
cp ~/Documents/Work/Sam\ Stevens\ Resume\ $(date +%Y).pdf ${output_dir}/resume.pdf
