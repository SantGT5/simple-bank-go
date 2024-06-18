migratup: ## Apply database migrations (up)
	@docker exec -it backend /bin/sh -c 'migrate -path db/migration -database "$$POSTGRES_URL?sslmode=disable" -verbose up'
.PHONY: migratup

migratdown: ## Revert database migrations (down)
	@docker exec -it backend /bin/sh -c 'migrate -path db/migration -database "$$POSTGRES_URL?sslmode=disable" -verbose down'
.PHONY: migratdown
