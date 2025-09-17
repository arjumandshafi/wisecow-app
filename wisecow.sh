#!/usr/bin/env bash

SRVPORT=4499
RSPFILE=response

# Add /usr/games to PATH so cowsay can be found
export PATH=$PATH:/usr/games

# Clean up any old pipes
rm -f $RSPFILE
mkfifo $RSPFILE

# Read the request (just the first line)
get_api() {
    read line
    echo "$line"
}

# Handle incoming request
handleRequest() {
    get_api
    mod=$(fortune)

cat <<EOF > $RSPFILE
HTTP/1.1 200 OK

<pre>$(cowsay "$mod")</pre>
EOF
}

# Check that all dependencies are installed
prerequisites() {
    for cmd in cowsay fortune nc; do
        if ! command -v $cmd >/dev/null 2>&1; then
            echo "Missing dependency: $cmd"
            exit 1
        fi
    done
}

# Start the server loop
main() {
    prerequisites
    echo "🐮 Wisecow server is running on port $SRVPORT..."

    while true; do
        cat $RSPFILE | nc -l -p $SRVPORT -q 1 | handleRequest
        sleep 0.01
    done
}

main
