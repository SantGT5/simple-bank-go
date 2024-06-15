ifneq (,$(wildcard .env))
	include .env
	export
	ENV_FILE_PARAM := --env-file .env
endif

.DEFAULT_GOAL := help

help:
	@awk -F ':|##' '/^[^\t].+:.*##/ { printf "\033[36mmake %-28s\033[0m -%s\n", $$1, $$NF }' $(MAKEFILE_LIST) | sort
.PHONY: help
