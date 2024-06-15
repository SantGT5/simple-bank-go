#----
# Docker
#----

start/dev: urls ## Start development environment
	@echo "Starting development environment..."
	@docker-compose $(DEV_COMPOSE) up --build $(arg)
.PHONY: start/dev

#----
# Backend test
#----

test: ## Run unit tests with coverage report
	@go test -v -cover -count=1 ./...
.PHONY: test

test/cover: ## Run unit tests with coverage report and race detection
	@go test -v -count=1 -race -coverprofile=coverage.out -covermode=atomic -p=1 ./...
.PHONY: test/cover

test/cover/html: test/cover ## Generate HTML coverage report
	@go tool cover -html=coverage.out -o coverage.html
.PHONY: test/cover/html
