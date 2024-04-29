postgres:
	docker run --name postgres16 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=root -d postgres:16.2-alpine3.19
.PHONY: postgres

createdb:
	docker exec -it postgres16 createdb --username=root --owner=root simple_bank
.PHONY: createdb

dropdb:
	docker exec -it postgres16 dropdb simple_bank
.PHONY: dropdb

migratup:
	migrate -path db/migration -database "postgresql://root:root@localhost:5432/simple_bank?sslmode=disable" -verbose up
.PHONY: migratup

migratdown:
	migrate -path db/migration -database "postgresql://root:root@localhost:5432/simple_bank?sslmode=disable" -verbose down
.PHONY: migratdown

sqlc:
	sqlc generate
.PHONY: sqlc

test:
	go test -v -cover -count=1 ./...
.PHONY: test

test/cover:
	go test -v -count=1 -race -coverprofile=coverage.out -covermode=atomic -p=1 ./...
.PHONY: test/cover

test/cover/html: test/cover
	go tool cover -html=coverage.out -o coverage.html
.PHONY: test/cover/html
