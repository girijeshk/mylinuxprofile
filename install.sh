#!/bin/bash

# This script will install this environment for the current user.

# move the current directorty to root location of my config
cd `dirname $0`

# save full path of root location
ROOTDIR=`pwd`

if [ "--run" !=  "$1" ]; then
	DRY=1;
	echo "This is a dry run. Use '$0 --run' for actual install. Work on to fix all the warnings before going for actual install.";
fi

warn() {
	echo "Warning: $1";
}

createAliasIfSafe() {
	if [ -e $2 ] || [ -L $2 ]; then
		warn "$2 already exists. Please remove it first and re-run the script";
	elif [ -z "$DRY" ]; then
		echo "creating link of $1 as $2";
		ln -sT $1 $2;
	fi
}

# vim configuration
createAliasIfSafe $ROOTDIR/vim ~/.vim
createAliasIfSafe $ROOTDIR/vim/vimrc ~/.vimrc
pushd $ROOTDIR/vim/pack/tpope/start
vim -u NONE -c "helptags fugitive/doc" -c q
popd

# tmux configuration
createAliasIfSafe $ROOTDIR/tmux/tmux.conf ~/.tmux.conf

