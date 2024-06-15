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

#----
# Info
#----

.PHONY: urls
urls: ## Show the urls to the running applications
	@echo "*------"
	@echo "* Simple Bank [dev]"
	@echo "*------\n"
