#----
# Compose
#----

define EXE_COMPOSE
    @docker compose $(COMMON_COMPOSE) $(1) $(COMPOSE_PROJECT_NAME) up --build
endef

start/dev: urls ## Start dev environment
	$(call EXE_COMPOSE, $(DEV_COMPOSE)) $(arg)
.PHONY: start/dev

start/ci: urls ## Start ci environment
	$(call EXE_COMPOSE, $(CI_COMPOSE)) $(arg)
.PHONY: start/ci

#----
# Backend test
#----

test: ## Run unit tests with coverage report
	@docker exec -t backend go test -v -count=1 -cover ./...
.PHONY: test

test/cover: ## Run unit tests with coverage report and race detection
	@docker exec -it backend go test -v -count=1 -race -coverprofile=tmp/coverage.out -covermode=atomic -p=1 ./...
.PHONY: test/cover

test/cover/html: test/cover ## Generate HTML coverage report
	@docker exec -it backend go tool cover -html=tmp/coverage.out -o tmp/coverage.html
.PHONY: test/cover/html
