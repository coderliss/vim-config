#!/bin/bash

rm -rf .vim .vimrc
cp -r $HOME/.vim $HOME/.vimrc .
git add --all
if [[ -z $1 ]] ; then
	git commit -m "auto management"
else
	git commit -m "$1"
fi

git push origin master
echo "backup ok"