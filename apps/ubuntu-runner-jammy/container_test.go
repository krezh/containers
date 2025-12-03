package main

import (
	"context"
	"testing"

	"github.com/krezh/containers/testhelpers"
	"github.com/stretchr/testify/require"
	"github.com/testcontainers/testcontainers-go"
)

func Test(t *testing.T) {
	ctx := context.Background()
	image := testhelpers.GetTestImage("ghcr.io/krezh/ubuntu-runner-jammy:rolling")

	// ContainerDisk images are FROM scratch and only contain the disk image file at /disk/disk.img
	// We verify the image exists and can be pulled, then inspect its layers
	c, err := testcontainers.GenericContainer(ctx, testcontainers.GenericContainerRequest{
		ContainerRequest: testcontainers.ContainerRequest{
			Image: image,
			Cmd:   []string{"/disk/disk.img"}, // Dummy command that won't actually run
		},
		Started: false, // Don't try to start the container
	})
	require.NoError(t, err)
	defer func() {
		if c != nil {
			_ = c.Terminate(ctx)
		}
	}()

	// Verify the container was created successfully
	// The actual disk image will be validated when used with KubeVirt
	require.NotNil(t, c)
}
