sqlc: ## Generate Go code from SQL files
	@docker exec -it backend sqlc generate
.PHONY: sqlc
