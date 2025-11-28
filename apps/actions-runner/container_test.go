package main

import (
	"context"
	"testing"

	"github.com/krezh/containers/testhelpers"
)

func Test(t *testing.T) {
	ctx := context.Background()
	image := testhelpers.GetTestImage("ghcr.io/krezh/actions-runner:rolling")
	testhelpers.TestFileExists(t, ctx, image, "/usr/local/bin/yq", nil)
	testhelpers.TestFileExists(t, ctx, image, "/usr/bin/gh", nil)
	testhelpers.TestFileExists(t, ctx, image, "/usr/bin/xz", nil)
}
