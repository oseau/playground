watch-go: ## auto rerun latest changed go file
	@echo "start!"
	@./watch-go.sh

watch-py: ## watch for python changes and run
	@echo "start!"
	@./watch-py.sh

init-py: ## init python dev environment
	@rm -rf .venv
	@python -m venv .venv
	@. .venv/bin/activate
	@pip install -r requirements.txt

start:
	@$(MAKE) log.info MSG="================ START ================"

end:
	@$(MAKE) log.info MSG="================= END ================="

# Absolutely awesome: http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help

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
