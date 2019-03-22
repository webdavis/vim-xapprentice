# This Dockerfile bootstraps Alpine Linux with vim-xapprentice, a Vim colorscheme.
#
# Create image:
#
#   $ sudo docker build \
#           --tag webdavis/vim-xapprentice:<git-commit hash> .
#
# Run container:
#
#   $ sudo docker run -d -t \
#           --hostname alpine \
#           --name vim_xapprentice_prod \
#           webdavis/vim-xapprentice:<git-commit hash>
#
# Enter container:
#
#   $ sudo docker exec -ti vim_xapprentice_prod /init /bin/bash -l
#
FROM webdavis/vim-plugin:alpine

# Tagbar complains if ctags aren't installed.
RUN curl -fLo "/root/.vim/autoload/plug.vim" --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install the latest Git commit of vim-xapprentice.
COPY ./test/files/vimrc /root/.vimrc
RUN sed -i -e "s/\(.*plug#begin.*\)/\1\\n\\nPlug 'webdavis\/vim-xapprentice'/" /root/.vimrc
COPY ./test/files/init.vim /root/.vim/
RUN ln -sf /root/.vim /root/.config/nvim

# Install Vim plugins.
RUN nvim -u /root/.vimrc +PlugInstall +qall

# Remove VCS files and directories.
RUN find . -path '.git/*' -delete

CMD ["/bin/bash"]
