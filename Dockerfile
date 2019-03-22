# This Dockerfile bootstraps Alpine Linux with vim-xapprentice, a Vim colorscheme.
#
# Create image:
#
#   $ sudo docker build \
#           --force-rm \
#           --tag vim-xapprentice-stage .
#
# Provision container:
#
#   $ sudo docker run -d -t \
#           --volume ./:/home/localuser/.vim \
#           --hostname alpine \
#           --name vim_xapprentice_stage \
#           vim-xapprentice-stage
#
#   $ sudo docker exec -t vim_xapprentice_stage /bin/bash './vim/test/files/linker.bash'
#
# Enter container:
#
#   $ sudo docker exec -ti vim_xapprentice_stage /init /bin/bash -l
#
FROM webdavis/vim-plugin:alpine

# Tagbar complains if ctags aren't installed.
RUN apk update --no-cache && apk add g++ \
    && git clone https://github.com/universal-ctags/ctags.git "${HOME}/ctags" \
    && cd ctags \
    && ./autogen.sh \
    && ./configure \
    && make \
    && sudo make install

CMD ["/bin/bash"]
