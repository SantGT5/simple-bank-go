#----
# Docker
#----

start/dev: urls ## Start development environment
	@echo "Starting development environment..."
	@docker compose $(DEV_COMPOSE) up --build $(arg)
.PHONY: start/dev

#----
# Backend test
#----

test: ## Run unit tests with coverage report
	@docker exec -it backend go test -v -cover -count=1 ./...
.PHONY: test

test/cover: ## Run unit tests with coverage report and race detection
	@docker exec -it backend go test -v -count=1 -race -coverprofile=bin/coverage.out -covermode=atomic -p=1 ./...
.PHONY: test/cover

test/cover/html: test/cover ## Generate HTML coverage report
	@docker exec -it backend go tool cover -html=bin/coverage.out -o bin/coverage.html
.PHONY: test/cover/html
