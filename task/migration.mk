define DB_MIGRATE
    @docker exec -it backend /bin/sh -c 'migrate -path db/migration -database "$$POSTGRES_URL?sslmode=disable" -verbose $(1)'
endef

migratup: ## Apply database migrations (up)
	$(call DB_MIGRATE, up)
.PHONY: migratup

migratdown: ## Revert database migrations (down)
	$(call DB_MIGRATE, down)
.PHONY: migratdown
