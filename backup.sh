#!/bin/bash

rm -rf ccls/.vim ccls/.vimrc
cp -r $HOME/.vim $HOME/.vimrc ccls
git add --all
if [[ -z $1 ]] ; then
	git commit -m "auto management"
else
	git commit -m "$1"
fi

git push origin master
echo "backup ok"
