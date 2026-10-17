package main

import (
	"context"
	"testing"

	"github.com/krezh/containers/testhelpers"
)

func Test(t *testing.T) {
	ctx := context.Background()
	image := testhelpers.GetTestImage("ghcr.io/krezh/stash:rolling")
	httpConfig := testhelpers.HTTPTestConfig{
		Port:       "9999",
		Path:       "/healthz",
		StatusCode: 200,
	}

	testhelpers.TestHTTPEndpoint(t, ctx, image, httpConfig, nil)

	// Kubernetes runs it as a UID absent from /etc/passwd; stash resolves the
	// current user at startup and panics unless USER/HOME are set. The image's
	// /config is owned by nobody, so the config file goes to /tmp instead.
	testhelpers.TestHTTPEndpoint(t, ctx, image, httpConfig, &testhelpers.ContainerConfig{
		Env:  map[string]string{"STASH_CONFIG_FILE": "/tmp/config.yml"},
		User: "1000:1000",
	})
}
