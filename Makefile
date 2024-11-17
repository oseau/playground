SHELL := /usr/bin/env bash -o errexit -o pipefail -o nounset

TAG := playground
TIMESTAMP := $(shell date +%Y_%m%d_%H%M)
FILENAME_PY := $(TIMESTAMP).py
FILENAME_GO := $(TIMESTAMP)_test.go

start: ## (kill existing and) start the playground
	@$(MAKE) log.info MSG="================ START ================"
	@docker stop $(TAG) --time 0 || true
	@docker build -t $(TAG) .
	@docker run -it --rm --name=$(TAG) -v $(shell pwd):/play -w /play $(TAG) /play/start

shell: ## login running container
	@$(MAKE) log.info MSG="================ LOGIN ================"
	@docker exec -it -w /play $(TAG) bash

py: ## add a python file and `start`
	@$(MAKE) log.info MSG="================ ADD $(FILENAME_PY) ================"
	@cp python.py $(FILENAME_PY)
	@emacsclient -n $(FILENAME_PY)
	@$(MAKE) start

go: ## add a go file and `start`
	@$(MAKE) log.info MSG="================ ADD $(FILENAME_GO) ================"
	@cp golang_test.go $(FILENAME_GO)
	@sed -i '' 's/Hello/Hello$(TIMESTAMP)/g' $(FILENAME_GO)
	@emacsclient -n $(FILENAME_GO)
	@$(MAKE) start

# https://www.gnu.org/software/make/manual/html_node/Options-Summary.html
MAKEFLAGS += --always-make

.DEFAULT_GOAL := help
# Modified from http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help:
	@grep -Eh '^[a-zA-Z_-]+:.*?##? .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?##? "}; {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}'


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
