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

func TestNixGitHubToken(t *testing.T) {
	ctx := context.Background()
	image := testhelpers.GetTestImage("ghcr.io/krezh/renovate-nix:rolling")

	testhelpers.TestCommandSucceeds(t, ctx, image,
		&testhelpers.ContainerConfig{Env: map[string]string{"RENOVATE_TOKEN": "test-token"}},
		"/entrypoint.sh",
		"grep", "access-tokens = github.com=test-token", "/home/ubuntu/.config/nix/nix.conf",
	)
}
