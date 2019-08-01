input=${1:-personal-website}
output=${2:-samuelstevens.github.io}
root=${3:-~/Development}
input_dir=${root}/${input}
output_dir=${root}/${output}

commit_message=${1:-"updated file(s) at "$(date)}

publish () {
  git add .
  git commit -m "$1"
  git push
}

./build.sh

python3 essays.py

cd $output_dir
publish $commit_message

