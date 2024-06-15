migratup: ## Apply database migrations (up)
	@migrate -path db/migration -database "postgres://admin:admin@localhost:5432/simple-bank?sslmode=disable" -verbose up
.PHONY: migratup

migratdown: ## Revert database migrations (down)
	@migrate -path db/migration -database "postgres://admin:admin@localhost:5432/simple-bank?sslmode=disable" -verbose down
.PHONY: migratdown

sqlc: ## Generate Go code from SQL files
	@sqlc generate
.PHONY: sqlc
