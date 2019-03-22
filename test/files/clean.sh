#!/usr/bin/env sh

# Remove the symlinks.
if test -L "./.vim/autoload/plug.vim"; then
    rm -f ./.vim/autoload/plug.vim
fi
if test -L "./.vim/init.vim"; then
    rm -f ./.vim/init.vim
fi

# vim-plug creates the plugged directory.
if test -d "./.vim/plugged"; then
    rm -rf ./.vim/plugged
fi
