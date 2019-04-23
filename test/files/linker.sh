#!/usr/bin/env sh

# Exit immediately if an error is detected.
set -e

# Echo the commands in this script to aid in debugging.
set -v

# Doing our best to ensure this is only executed in the Docker container.
if [ ! -f '/.dockerenv' ]; then
    exit 1
fi

home=`builtin eval echo ~`

ln -sf "${home}/.vim/test/files/vimrc" "${home}/.vimrc"
ln -sf "${home}/.vim" "${home}/.config/nvim"
ln -sf "${home}/.vim/test/files/init.vim" "${home}/.vim/init.vim"

# Install Plug, a Vim plugin manager.
curl -fLo "${home}/plug.vim" https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -sf "${home}/plug.vim" "${home}/.vim/autoload/plug.vim"

# This allows you to run :PlugInstall without entering Vim. See this post:
# https://github.com/junegunn/vim-plug/issues/225
nvim -u "${home}/.vimrc" +PlugInstall +qall
