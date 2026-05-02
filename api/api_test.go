package main

import (
	"testing"
)

func TestLargest(t *testing.T) {
	result := ReturnLargest(10, 15)
	expected := 15

	if result != expected {
		t.Errorf("Largest(10, 15) = %d; Expected = %d", result, expected)
	}
}