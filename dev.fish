python -m http.server --directory $HOME/Development/samuelstevens.github.io &
set server_id $last_pid

trap "kill $server_id" SIGEXIT
trap "kill $server_id" SIGINT

# clean
fd --type f . $HOME/Development/samuelstevens.github.io --exec-batch rm 

source build.fish

# full build
for f in (fd -e md)
    htmlify $f
end

echo "Going to http://localhost:8000"
open http://localhost:8000

fd . --type file | entr fish build.fish
