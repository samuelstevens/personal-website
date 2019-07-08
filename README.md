# samuelstevens.me

This is the repo I'm using to set up my website, and then [this repo](https://github.com/samuelstevens/samuelstevens.github.io) is the one that GitHub publishes (I know I need to use Netifly).

```bash
python3 essays.py # rips files from Bear's SQLite databse and puts them in /essays

./build.sh # builds the website

./serve.sh # builds the website on file change, requires nodemon

./publish.sh # publishes the website via git commit
```

All scripts are based on my personal file structures.

## To Do

- [] Add a favicon
- [] Add Google SEO, robots.txt, etc.
- [] Convert python script to bash, or bash to python
- [] Preprocess HTML by removing excess whitespace
