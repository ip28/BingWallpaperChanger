
PICTURE_DIR="$HOME/Pictures/bing-wallpapers/"

mkdir -p $PICTURE_DIR

urls=( $(curl -s http://www.bing.com | \
    grep -Eo "url:'.*?'" | \
    sed -e "s/url:'\([^']*\)'.*/http:\/\/bing.com\1/" | \
    sed -e "s/\\\//g") )

for p in ${urls[@]}; do
    filename=$(echo $p|sed -e "s/.*\/\(.*\)/\1/")
    
    if [ ! -f $PICTURE_DIR/$filename ]; then
        echo "Downloading: $filename ..."
        curl -Lo "$PICTURE_DIR/$filename" $p
		osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$PICTURE_DIR/$filename\""
    else
        echo "Skipping: $filename ..."
        osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$PICTURE_DIR/$filename\""
    fi
done
