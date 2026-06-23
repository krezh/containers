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

	// nix in PATH must be the wrapper, not the real binary
	testhelpers.TestCommandSucceeds(t, ctx, image, nil,
		"sh", "-c", `grep -q "RENOVATE_TOKEN" "$(command -v nix)"`,
	)

	// wrapper must set NIX_CONFIG with the token when RENOVATE_TOKEN is present
	testhelpers.TestCommandSucceeds(t, ctx, image, nil,
		"sh", "-c", `grep -q 'NIX_CONFIG="access-tokens = github.com=$RENOVATE_TOKEN"' /opt/nix/wrapper/nix`,
	)
}
