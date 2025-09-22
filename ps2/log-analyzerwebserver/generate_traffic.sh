#!/bin/bash
# Traffic generator for Apache log testing
# This will send requests to your web server

# URL of the web server
URL="http://localhost"

# Number of requests per page
REQ_PER_PAGE=20

# List of pages to request (simulate some 404 errors)
PAGES=("/" "/index.html" "/about.html" "/contact.html" "/login" "/notfound" "/error")

echo "Starting traffic generation..."

for i in $(seq 1 $REQ_PER_PAGE)
do
  for PAGE in "${PAGES[@]}"
  do
    curl -s -o /dev/null "$URL$PAGE"
    echo "Requested: $URL$PAGE"
  done
done

echo "Traffic generation completed!"
