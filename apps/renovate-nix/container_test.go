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

	// renovate in PATH must be the launcher wrapper, not the real binary directly,
	// so nix.conf gets set up even when the operator invokes "renovate" as
	// Command, bypassing the image ENTRYPOINT.
	testhelpers.TestCommandSucceeds(t, ctx, image, nil,
		"sh", "-c", `[ "$(command -v renovate)" = "/opt/nix/wrapper/renovate" ]`,
	)

	// launcher must write nix's access-tokens into /etc/nix/nix.conf from
	// RENOVATE_TOKEN before running renovate, so nix authenticates to GitHub
	// regardless of which later process shells out to nix.
	testhelpers.TestCommandSucceeds(t, ctx, image,
		&testhelpers.ContainerConfig{Env: map[string]string{"RENOVATE_TOKEN": "test-token-123"}},
		"sh", "-c", `renovate --version >/dev/null 2>&1; grep -q "access-tokens = github.com=test-token-123" /etc/nix/nix.conf`,
	)

	// without a token, nix.conf must not gain a bogus access-tokens line
	testhelpers.TestCommandSucceeds(t, ctx, image, nil,
		"sh", "-c", `renovate --version >/dev/null 2>&1; ! grep -q access-tokens /etc/nix/nix.conf`,
	)
}
