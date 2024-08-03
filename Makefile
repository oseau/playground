SHELL := /usr/bin/env bash -o errexit -o pipefail -o nounset

TAG := playground

start: ## (kill existing and) start the playground
	@$(MAKE) log.info MSG="================ START ================"
	@docker stop $(TAG) --time 0 || true
	@docker build -t $(TAG) .
	@docker run --rm --name=$(TAG) -v $(shell pwd):/play -w /play $(TAG) /play/start

shell: ## login running container
	@$(MAKE) log.info MSG="================ LOGIN ================"
	@docker exec -it -w /play $(TAG) bash

py: ## add a python file
	@$(MAKE) log.info MSG="================ ADD PYTHON FILE ================"
	@cp python.py $(shell date +%Y_%m%d_%H%M).py

go: ## add a go file
	@$(MAKE) log.info MSG="================ ADD GO FILE ================"
	@cp golang_test.go $(shell date +%Y_%m%d_%H%M)_test.go

# https://www.gnu.org/software/make/manual/html_node/Options-Summary.html
MAKEFLAGS += --always-make

.DEFAULT_GOAL := help
# Modified from http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help:
	@grep -Eh '^[a-zA-Z_-]+:.*?##? .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?##? "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


# https://github.com/zephinzer/godev/blob/62012ce006df8a3131ee93a74bcec2066405fb60/Makefile#L220
## blue logs
log.debug:
	-@printf -- "\033[0;36m_ [DEBUG] ${MSG}\033[0m\n"

## green logs
log.info:
	-@printf -- "\033[0;32m> [INFO] ${MSG}\033[0m\n"

## yellow logs
log.warn:
	-@printf -- "\033[0;33m? [WARN] ${MSG}\033[0m\n"

## red logs (die mf)
log.error:
	-@printf -- "\033[0;31m! [ERROR] ${MSG}\033[0m\n"
