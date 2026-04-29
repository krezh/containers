package main

import (
	"context"
	"testing"

	"github.com/krezh/containers/testhelpers"
)

func Test(t *testing.T) {
	ctx := context.Background()
	image := testhelpers.GetTestImage("ghcr.io/krezh/renovate-nix:rolling")

	testhelpers.TestFileExists(t, ctx, image, "/home/ubuntu/.nix-profile/bin/nix", nil)
	testhelpers.TestCommandSucceeds(t, ctx, image, nil, "sh", "-c", "/home/ubuntu/.nix-profile/bin/nix --version")
}
