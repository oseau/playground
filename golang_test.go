package playground

import "testing"

func Hello() string {
	return "world"
}

func TestHello(t *testing.T) {
	if "world" != Hello() {
		t.Error("should not enter this branch")
	}
}
