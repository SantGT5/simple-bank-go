package database

import (
	"database/sql"
	"log"
	"os"
	"testing"

	db "github.com/SantGT5/simple-bank-go/db/sqlc"
	_ "github.com/lib/pq"
)

const (
	dbDriver = "postgres"
	dbSource = "postgres://admin:admin@localhost:5432/simple-bank?sslmode=disable"
)

var testQueries *db.Queries

var testDB *sql.DB

func TestMain(m *testing.M) {
	var err error

	testDB, err = sql.Open(dbDriver, dbSource)

	if err != nil {
		log.Fatal("cannot connect to db: ", err)
	}

	testQueries = db.New(testDB)

	os.Exit(m.Run())
}
