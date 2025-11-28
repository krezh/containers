package main

import (
	"context"
	"testing"

	"github.com/krezh/containers/testhelpers"
)

func Test(t *testing.T) {
	ctx := context.Background()
	image := testhelpers.GetTestImage("ghcr.io/krezh/vrising:rolling")
	testhelpers.TestFileExists(t, ctx, image, "/usr/bin/steamcmd", nil)
}
