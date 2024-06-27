#----
# Imports
#----

include $(wildcard task/*.mk)

#----
# Variables
#----

PROJECT_NAME := simple-bank
COMPOSE_PROJECT_NAME := --project-name $(PROJECT_NAME)
COMMON_COMPOSE := -f docker/compose.yaml

DEV_COMPOSE := $(COMMON_COMPOSE) -f docker/compose.dev.yaml $(COMPOSE_PROJECT_NAME)
CI_COMPOSE := $(COMMON_COMPOSE) -f docker/compose.ci.yaml $(COMPOSE_PROJECT_NAME)

#----
# Info
#----

urls: ## Show the urls to the running applications
	@echo "*------"
	@echo "* Simple Bank [dev]"
	@echo "*------\n"
.PHONY: urls

#----
# Others
#----

quality: ## Check code formatting
	@gofmt -l ./backend
	@if [ -n "$$(gofmt -l ./backend)" ]; then echo "Code is not formatted. Run 'make format' to format.\n"; exit 1; fi
.PHONY: quality

format: ## Code formatting
	@gofmt -w ./backend
.PHONY: format
