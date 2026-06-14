package main

import (
	"context"
	"testing"

	"github.com/krezh/containers/testhelpers"
)

func TestAgentmemoryBinary(t *testing.T) {
	ctx := context.Background()
	image := testhelpers.GetTestImage("ghcr.io/krezh/agentmemory:rolling")
	testhelpers.TestCommandSucceeds(t, ctx, image, nil,
		"sh", "-c", "command -v agentmemory && command -v iii")
}
