sqlc: ## Generate Go code from SQL files
	@docker exec -it backend sqlc generate
.PHONY: sqlc

mock: ## Generate mock data
	@docker exec -it backend mockgen -package mockdb -destination db/mock/store.go github.com/SantGT5/simple-bank-go/db/sqlc Store
.PHONY: mock
