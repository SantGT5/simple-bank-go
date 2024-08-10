package util

import (
	"testing"

	"github.com/stretchr/testify/require"
)

type TestCase struct {
	name     string
	currency string
	expected bool
}

func TestIsSupportedCurrency(t *testing.T) {
	cases := []TestCase{
		{"USD is supported", USD, true},
		{"EUR is supported", EUR, true},
		{"CAD is supported", CAD, true},
		{"BR is not supported", "BR", false},
	}

	for _, tc := range cases {
		t.Run(tc.name, func(t *testing.T) {
			isSupported := IsSupportedCurrency(tc.currency)

			require.Equal(t, tc.expected, isSupported)
		})
	}
}
