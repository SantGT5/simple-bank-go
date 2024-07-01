sqlc: ## Generate Go code from SQL files
	@docker exec -it backend sqlc generate
.PHONY: sqlc

mock: ## Generate mock data
	@docker exec -it backend mockgen -package mockdb -destination db/mock/store.go github.com/SantGT5/simple-bank-go/db/sqlc Store
.PHONY: mock

#----
# Migration
#----

define DB_MIGRATE
    @docker exec -it backend /bin/sh -c 'migrate -path db/migration -database "$$POSTGRES_URL?sslmode=disable" -verbose $(1)'
endef

migrate-up: ## Apply database migrations (up)
	$(call DB_MIGRATE, up)
.PHONY: migrate-up

migrate-down: ## Revert database migrations (down)
	$(call DB_MIGRATE, down)
.PHONY: migrate-down

migrate-reapply: migrate-down migrate-up ## Revert and then re-apply all database migrations
.PHONY: migrate-reapply
