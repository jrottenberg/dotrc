#!/bin/sh
#
set -e

DOTRC_DIR=$(echo $0 | sed -e 's/\(.*\)\/.*/\1/')
DOTRC_FILE=$(echo $0 | sed -e 's/.*\///')
[ "$DOTRC_DIR" = "." ] && DOTRC_DIR=$(pwd)

for F in $(ls $DOTRC_DIR | grep -v $DOTRC_FILE)
do
	if [ ! -h "$HOME/.$F" ]; then
	    if [ -f "$HOME/.$F" ]; then 
   	        echo "~/.$F already exists, moving it."
   	        mv ~/.$F ~/.$F.`date +%Y%m%d-%H%M`
        fi
	    ln -s "$DOTRC_DIR/$F" "$HOME/.$F"
   	fi
done
