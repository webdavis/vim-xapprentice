#
# This makefile orchestrates the staging environment.
#
# Usage:
#
# - make          by default, make will pull the latest commit from the registry and run the container detached
# - make build    build the staging image
# - make stop     stop the container
# - make remove   stop the container and delete the image
# - make run      set up a staging container for working with diffs in real-time
#
# Submake usage:
#
# These will execute the Makefile in the corresponding subdirectory. Execute a specific
# target by using the "TARGET" flag.
#
# - make docker [TARGET=target]
#

.PHONY: build stop remove run docker vim nvim


# If the "user" has been added to the "docker" group then this can be changed to
# "docker := docker". Alternatively, run make with the "-e" flag, like so:
#
# 	make -e docker='docker'
#
docker := sudo docker

# Constants.
name := vim_xapprentice_stage
stage := vim-xapprentice-stage

default: run

build:
	$(info Building ${stage} ...)
	@${docker} build --force-rm --tag ${stage} .

stop:
ifeq ($(shell ${docker} inspect --format "{{.State.Running}}" ${name} 2>/dev/null),true)
	$(info Shutting down ${name})
	@${docker} exec -t ${name} /bin/bash './.vim/test/files/clean.sh'
	@${docker} container stop ${name}
	@${docker} rm -f ${name}
endif

remove: stop
	$(info Deleting ${stage} ...)
	@${docker} image rm ${stage}

run: stop build
	$(info Running ${stage} ...)
	@${docker} run -d -t \
		--volume $(shell pwd):/root/.vim \
		--hostname alpine \
		--name ${name} \
		${stage}
	@${docker} exec -t vim_xapprentice_stage /bin/bash './.vim/test/files/linker.sh'



# Submake ...
########################################################################
docker:
	$(info Running tests in local environment ...)
	@$(MAKE) --directory=$@ $(TARGET)
