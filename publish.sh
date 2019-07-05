input=personal-website
output=samuelstevens.github.io
root=~/Development
input_dir=${root}/${input}
output_dir=${root}/${output}

commit_message=${1:-"updated file(s) at "$(date)}

publish () {
  git add .
  git commit -m "$1"
  git push
}

(cd $output_dir && publish $commit_message)
