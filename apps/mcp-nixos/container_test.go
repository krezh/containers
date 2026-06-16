package main

import (
	"context"
	"testing"

	"github.com/krezh/containers/testhelpers"
)

func Test(t *testing.T) {
	ctx := context.Background()
	image := testhelpers.GetTestImage("ghcr.io/krezh/renovate-nix:rolling")

	// Test that Nix is installed and available
	testhelpers.TestCommandSucceeds(t, ctx, image, nil, "nix", "--version")

	// Test that renovate still works
	testhelpers.TestCommandSucceeds(t, ctx, image, nil, "renovate", "--version")
}
