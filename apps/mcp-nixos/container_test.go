package main

import (
	"context"
	"testing"

	"github.com/krezh/containers/testhelpers"
)

func Test(t *testing.T) {
	ctx := context.Background()
	image := testhelpers.GetTestImage("ghcr.io/krezh/mcp-nixos:rolling")

	// mcp-nixos defaults to stdio transport; with stdin closed it reads EOF
	// and exits 0, which is enough to prove the entrypoint starts cleanly.
	testhelpers.TestCommandSucceeds(t, ctx, image, nil, "mcp-nixos")
}
