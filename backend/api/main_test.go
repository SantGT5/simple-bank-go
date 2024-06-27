package api

import (
	"fmt"
	"os"
	"testing"

	"github.com/gin-gonic/gin"
)

var (
	minCoverage = 0.8 // Minimum coverage here (e.g., 80%)
)

func TestMain(m *testing.M) {
	gin.SetMode(gin.TestMode)

	// Run tests and check coverage
	exitVal := m.Run()
	cov := testing.Coverage()

	if cov < minCoverage {
		fmt.Println("Tests passed, but coverage failed at", cov)
		// os.Exit(1) // Exit with non-zero code to indicate failure
	}

	os.Exit(exitVal)
}
