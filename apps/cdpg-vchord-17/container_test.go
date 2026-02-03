package main

import (
	"context"
	"testing"

	"github.com/krezh/containers/testhelpers"
)

func Test(t *testing.T) {
	ctx := context.Background()
	image := testhelpers.GetTestImage("ghcr.io/krezh/cdpg-vchord:rolling")
	testhelpers.TestFileExists(t, ctx, image, "/usr/pgsql-16/lib/vchord.so", nil)
}
