ifneq (,$(wildcard .env))
	include .env
	export
	ENV_FILE_PARAM := --env-file .env
endif

.DEFAULT_GOAL := help

help: ## Show command list (default)
	@awk -F ':|##' '/^[^\t].+:.*##/ { printf "\033[36mmake %-28s\033[0m -%s\n", $$1, $$NF }' $(MAKEFILE_LIST) | sort
.PHONY: help

# Check that given variables are set and all have non-empty values.
#
# Params:
#   1. Variable name(s) to test.
#   2. (optional) Error message to print.
# 
# Usage:
# $(call CHECK_DEFINED, MY_FLAG)
# $(call CHECK_DEFINED, MY_FLAG1 MY_FLAG2)
# 
# $(call CHECK_DEFINED, \
#             MY_FLAG1 \
#             MY_FLAG2, \
#         CUSTOM_ERROR_MESSAGE)
define check_defined
$(foreach var,$1, \
    $(if $(value $(var)),, \
        $(error Undefined variable `$(var)`$(if $2, ($(strip $(value 2)))))))
endef
