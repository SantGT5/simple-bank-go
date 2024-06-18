package main

import (
	"database/sql"
	"log"
	"os"

	"github.com/SantGT5/simple-bank-go/api"
	db "github.com/SantGT5/simple-bank-go/db/sqlc"

	_ "github.com/lib/pq"
)

var (
	dbDriver      = "postgres"
	dbSource      = os.Getenv("POSTGRES_URL") + "?sslmode=disable"
	serverAddress = ":" + os.Getenv("BACKEND_PORT")
)

func main() {
	conn, err := sql.Open(dbDriver, dbSource)

	if err != nil {
		log.Fatal("cannot connect to db: ", err)
	}

	store := db.NewStore(conn)
	server := api.NewServer(store)

	err = server.Start(serverAddress)

	if err != nil {
		log.Fatal("cannot start server: ", err)
	}
}
