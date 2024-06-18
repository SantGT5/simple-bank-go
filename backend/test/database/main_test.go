package database

import (
	"database/sql"
	"fmt"
	"log"
	"os"
	"testing"

	db "github.com/SantGT5/simple-bank-go/db/sqlc"
	_ "github.com/lib/pq"
)

var (
	dbDriver    = "postgres"
	dbSource    = os.Getenv("POSTGRES_URL") + "?sslmode=disable"
	minCoverage = 0.8 // Minimum coverage here (e.g., 80%)
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

	// Run tests and check coverage
	exitVal := m.Run()
	cov := testing.Coverage()

	if cov < minCoverage {
		fmt.Println("Tests passed, but coverage failed at", cov)
		// os.Exit(1) // Exit with non-zero code to indicate failure
	}

	os.Exit(exitVal)
}
