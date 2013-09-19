#!/bin/sh

if [ -z "$1" ]
then
	echo "Usage: $0 ROOT_URI"
	echo "  ROOT_URI: the web root to crawl."
	exit 1
fi

ROOT_URI=$1
# Ensure single trailing slash
ROOT_URI=${ROOT_URI%*/}/

# Add -F xml for debugging to also outupt to a file
linkchecker "$ROOT_URI" -o xml -v \
	--ignore-url="$ROOT_URI(forum|docs/python/|ide|tickets|userman|search.php)" \
	--ignore-url="!$ROOT_URI" \
	| python sitemapgen.py - "$ROOT_URI" > sitemap.xml

exit 0
