package main

import (
	"context"
	"testing"

	"github.com/krezh/containers/testhelpers"
)

func Test(t *testing.T) {
	ctx := context.Background()
	image := testhelpers.GetTestImage("ghcr.io/krezh/cdpg-vchord:rolling")

	testhelpers.TestFileExists(t, ctx, image, "/usr/pgsql-18/lib/vchord.so", nil)
	testhelpers.TestFileExists(t, ctx, image, "/usr/pgsql-18/lib/timescaledb.so", nil)
	testhelpers.TestCommandSucceeds(t, ctx, image, nil, "sh", "-c", "ls /usr/pgsql-18/lib/timescaledb-tsl-*.so")
	testhelpers.TestCommandSucceeds(t, ctx, image, nil, "sh", "-c", "test $(id -u) -ne 0")
}
