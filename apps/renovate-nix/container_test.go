package main

import (
	"context"
	"testing"

	"github.com/krezh/containers/testhelpers"
)

func Test(t *testing.T) {
	ctx := context.Background()
	image := testhelpers.GetTestImage("ghcr.io/krezh/renovate-nix:rolling")

	// Test that entrypoint script exists and is executable
	testhelpers.TestFileExists(t, ctx, image, "/usr/local/bin/entrypoint.sh", nil)

	// Test that the entrypoint installs Nix and it works
	// The entrypoint will install Nix on first run, then verify it's available
	testhelpers.TestCommandSucceeds(t, ctx, image, nil, "/usr/local/bin/entrypoint.sh", "--version")
}
