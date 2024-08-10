package util

import (
	"fmt"
	"regexp"
	"strings"
	"testing"
	"unicode"
	"unicode/utf8"

	"github.com/stretchr/testify/require"
)

func TestRandomInt(t *testing.T) {
	tests := []struct {
		name string
		min  int64
		max  int64
	}{
		{"Mixed range", -5, 5},
		{"Normal range", 1, 10},
		{"Negative range", -10, -1},
		{"Single value range", 5, 5},
	}

	for _, tc := range tests {
		t.Run(tc.name, func(t *testing.T) {
			// Run the test multiple times to ensure randomness is tested properly
			for i := 0; i < 100; i++ {
				result := RandomInt(tc.min, tc.max)
				require.GreaterOrEqual(t, result, tc.min, "result should be greater than or equal to min")
				require.LessOrEqual(t, result, tc.max, "result should be less than or equal to max")
			}
		})
	}

	// Additional test to ensure function panics if min > max (if such behavior is desired)
	t.Run("Min greater than Max", func(t *testing.T) {
		require.Panics(t, func() {
			RandomInt(10, 5)
		}, "RandomInt should panic if min is greater than max")
	})
}

func TestRandomString(t *testing.T) {

	tests := []struct {
		name string
		n    uint8
	}{
		{"Length 1", 1},
		{"Length 5", 5},
		{"Length 10", 10},
		{"Zero length", 0},
		{"Large length", 100},
	}

	for _, tc := range tests {
		t.Run(tc.name, func(t *testing.T) {
			result := RandomString(tc.n)

			// Check that the generated string has the correct length
			require.Equal(t, int(tc.n), utf8.RuneCountInString(result))

			// Check that the string contains only valid characters from the alphabet
			for _, char := range result {
				require.True(t, unicode.IsLower(char), "character should be a lowercase letter")
				require.Contains(t, alphabet, string(char), "character should be in the alphabet")
			}
		})
	}
}

func TestRandomEmail(t *testing.T) {
	for i := 0; i < 10; i++ {
		email := RandomEmail()

		// Check that the email has the correct format using a regular expression
		emailRegex := regexp.MustCompile(`^[a-z]{6}@email\.com$`)
		require.True(t, emailRegex.MatchString(email), fmt.Sprintf("Generated email does not match the expected format: %s", email))

		// Split the email into local part and domain part
		parts := strings.Split(email, "@")
		require.Len(t, parts, 2, "Email should contain one @ symbol")

		// Validate the local part (before @)
		localPart := parts[0]
		require.Equal(t, 6, len(localPart), "The local part of the email should be 6 characters long")
	}
}
