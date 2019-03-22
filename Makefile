# This makefile pushes the lastest commit from vim-xapprentice to Docker Hub, and can be
# found at https://hub.docker.com/r/webdavis/vim-plugin
#
# Usage:
#
# - make          by default, make will pull the latest commit from the registry and run the container detached
# - make run      run the lastest commit from Docker Hub
# - make stop     stop the container
# - make remove   stop the container and delete the image
# - make build    always builds the lastest commit from Docker Hub. If there isn't a Docker
#                 Hub tag that matches the latest GitHub commit, then this will Build the image.
# - make push     rebuild the machine, locking in the latest changes, and then push to Docker Hub
#

.PHONY: stop remove run build test push $(wildcard docker/*)

# If the "user" has been added to the "docker" group then this can be changed to
# "docker := docker". Alternatively, run make with the "-e" flag, like so:
#
# 	make -e docker='docker'
#
docker := sudo docker

# Constants.
profile := webdavis
repo := vim-xapprentice
name := $(subst -,_,${repo})_prod
img := ${profile}/${repo}
tag := $$(git rev-parse origin/master)
HEAD := ${img}:${tag}
latest := ${img}:latest

default: run

# Stop and remove the production container.
stop:
ifeq ($(shell ${docker} inspect --format "{{.State.Running}}" ${name} 2>/dev/null),true)
	@${docker} container stop ${name}
	@${docker} rm -f ${name}
endif

# Remove the production image.
remove: stop
	-${docker} image rm -f ${HEAD}
	-${docker} image rm -f ${latest}

try: remove
ifneq ($(shell curl --silent --fail -lSL https://index.docker.io/v1/repositories/${img}/tags/latest 2>&1),[])
	@:$(info This image is not stored on Docker Hub yet.)
	$(info Use the command "make push" to push the latest commit to Docker Hub.)
else
	@${docker} run -d -t \
		--hostname alpine \
		--name ${name} \
		${latest}
endif


# TravisCI ...
########################################################################
build:
ifneq ($(shell curl --silent --fail -lSL https://index.docker.io/v1/repositories/${img}/tags/${tag} 2>&1),[])
	@${docker} build --force-rm --tag ${HEAD} .
else
	@:$(info Docker Hub is up to date.)
	$(info Use the command "make run" to pull the latest image and start the container.)
endif

run:
ifneq ($(shell ${docker} inspect --format "{{.State.Running}}" ${name} 2>/dev/null),true)
	@${docker} run -d -t \
		--hostname alpine \
		--name ${name} \
		${HEAD}
endif

# Submake.
test:
	$(info Running tests in local environment ...)
	@$(MAKE) --directory=$@ $(TARGET)

editors := vim nvim

$(editors):
	@/bin/sh -c 'if test $(@F) != vim -a $(@F) != nvim; then exit 1; fi'
	${docker} exec -ti ${name} /bin/bash -c 'cd /root/.vim/plugged/vim-xapprentice/test && make --output-sync=recurse $(@F)'

# Update Docker Hub with latest commit.
push:
	@${docker} tag ${HEAD} ${latest}
	@${docker} push ${img}
