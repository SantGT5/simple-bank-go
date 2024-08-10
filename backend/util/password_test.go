package util

import (
	"testing"

	"github.com/stretchr/testify/require"
	"golang.org/x/crypto/bcrypt"
)

func TestPassword(t *testing.T) {
	// Subtest for a normal case
	t.Run("correct password", func(t *testing.T) {
		password := RandomString(6)
		hashed, err := HashPassword(password)

		require.NoError(t, err)
		require.NotEmpty(t, hashed)

		err = CheckPassword(password, hashed)
		require.NoError(t, err)
	})

	// Subtest for an incorrect password
	t.Run("incorrect password", func(t *testing.T) {
		password := RandomString(6)
		hashed, err := HashPassword(password)

		require.NoError(t, err)
		require.NotEmpty(t, hashed)

		wrongPassword := RandomString(6)

		err = CheckPassword(wrongPassword, hashed)
		require.EqualError(t, err, bcrypt.ErrMismatchedHashAndPassword.Error())
	})

	// Subtest for checking that the same password doesn't produce the same hash
	t.Run("different hashes for the same password", func(t *testing.T) {
		password := RandomString(6)

		hashed1, err := HashPassword(password)
		require.NoError(t, err)
		require.NotEmpty(t, hashed1)

		hashed2, err := HashPassword(password)
		require.NoError(t, err)
		require.NotEmpty(t, hashed2)

		require.NotEqual(t, hashed1, hashed2, "Hashes for the same password should be different")
	})

	// Subtest for edge case of an empty password
	t.Run("empty password", func(t *testing.T) {
		password := ""

		hashed, err := HashPassword(password)
		require.NoError(t, err)
		require.NotEmpty(t, hashed)

		err = CheckPassword(password, hashed)
		require.NoError(t, err)
	})

	// Subtest for edge case of a long password
	t.Run("long password", func(t *testing.T) {
		password := RandomString(70)

		hashed, err := HashPassword(password)
		require.NoError(t, err)
		require.NotEmpty(t, hashed)

		err = CheckPassword(password, hashed)
		require.NoError(t, err)
	})

	// Subtest for edge case of a password with special characters
	t.Run("password with special characters", func(t *testing.T) {
		password := "@#$%^&*()!"

		hashed, err := HashPassword(password)
		require.NoError(t, err)
		require.NotEmpty(t, hashed)

		err = CheckPassword(password, hashed)
		require.NoError(t, err)
	})
}
