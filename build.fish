set output $HOME/Development/samuelstevens.github.io

function htmlify
    set md $argv[1]

    set dir $output/(dirname $md)
    mkdir -p $dir

    set html $dir/(basename -s .md $md).html
    
    pandoc \
        --from markdown+backtick_code_blocks+link_attributes \
        --to html5 \
        --citeproc \
        --standalone \
        --template template.html \
        --ascii \
        $md \
        --out $html
end

function copy-file
    set f $argv[1]
    set dir $output/(dirname $f)
    mkdir -p $dir
    cp $f $dir/(basename $f)
end

function build
    # copy css files
    for f in (fd -e css)
        copy-file $f
    end
    
    set latest (fd -e md | xargs ls -t | head -n 1) 
    htmlify $latest

    for f in (fd -e html)
        if test $f = "template.html"
            continue
        end

        copy-file $f
    end

    for f in (fd -e js)
        copy-file $f
    end

    for f in (fd -e js)
        copy-file $f
    end
    
    for f in (fd -e jpg -e png -e jpeg)
        copy-file $f
    end
    
    cp ~/Documents/school/grad-school/cv/cv.pdf $output
    cp ~/Development/airpods/dist/Airpods.dmg $output
    cp CNAME $output

    echo Incrementally built at (date)
end

build
