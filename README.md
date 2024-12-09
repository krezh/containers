<!---
NOTE: AUTO-GENERATED FILE
to edit this file, instead edit its template at: .github/templates/README.md.j2
-->
<div align="center">


## Containers

_An opinionated collection of container images_

</div>

## Mission statement

The goal of this project is to support [semantically versioned](https://semver.org/), [rootless](https://rootlesscontaine.rs/), and [multiple architecture](https://www.docker.com/blog/multi-arch-build-and-images-the-simple-way/) containers for various applications.

We also try to adhere to a [KISS principle](https://en.wikipedia.org/wiki/KISS_principle), logging to stdout, [one process per container](https://testdriven.io/tips/59de3279-4a2d-4556-9cd0-b444249ed31e/), no [s6-overlay](https://github.com/just-containers/s6-overlay) and all images are built on top of [Alpine](https://hub.docker.com/_/alpine) or [Ubuntu](https://hub.docker.com/_/ubuntu).

## Passing arguments to a application

Some applications do not support defining configuration via environment variables and instead only allow certain config to be set in the command line arguments for the app. To circumvent this, for applications that have an `entrypoint.sh` read below.

1. First read the Kubernetes docs on [defining command and arguments for a Container](https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/).
2. Look up the documentation for the application and find a argument you would like to set.
3. Set the argument in the `args` section, be sure to include `entrypoint.sh` as the first arg and any application specific arguments thereafter.

    ```yaml
    args:
      - /entrypoint.sh
      - --port
      - "8080"
    ```

## Configuration volume

For applications that need to have persistent configuration data the config volume is hardcoded to `/config` inside the container. This is not able to be changed in most cases.

## Available Images

Each Image will be built with a `rolling` tag, along with tags specific to it's version. Available Images Below

### App Images

Container | Channel | Image | Latest Tags
--- | --- | --- | ---
[actions-runner](https://github.com/krezh/containers/pkgs/container/actions-runner) | stable | ghcr.io/krezh/actions-runner |![2](https://img.shields.io/badge/2-blue?style=flat-square) ![2.321](https://img.shields.io/badge/2.321-blue?style=flat-square) ![2.321.0](https://img.shields.io/badge/2.321.0-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-green?style=flat-square)
[opentofu-runner](https://github.com/krezh/containers/pkgs/container/opentofu-runner) | stable | ghcr.io/krezh/opentofu-runner |![0](https://img.shields.io/badge/0-blue?style=flat-square) ![0.16](https://img.shields.io/badge/0.16-blue?style=flat-square) ![0.16.0-rc](https://img.shields.io/badge/0.16.0--rc-blue?style=flat-square) ![0.16.0-rc.3](https://img.shields.io/badge/0.16.0--rc.3-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-green?style=flat-square)
[par2cmdline-turbo](https://github.com/krezh/containers/pkgs/container/par2cmdline-turbo) | stable | ghcr.io/krezh/par2cmdline-turbo |![1.1.1](https://img.shields.io/badge/1.1.1-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-green?style=flat-square)
[sabnzbd](https://github.com/krezh/containers/pkgs/container/sabnzbd) | stable | ghcr.io/krezh/sabnzbd |![4](https://img.shields.io/badge/4-blue?style=flat-square) ![4.4](https://img.shields.io/badge/4.4-blue?style=flat-square) ![4.4.0](https://img.shields.io/badge/4.4.0-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-green?style=flat-square)
[valkey](https://github.com/krezh/containers/pkgs/container/valkey) | alpine | ghcr.io/krezh/valkey |![8.0.1](https://img.shields.io/badge/8.0.1-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-green?style=flat-square)
[whisparr-nightly](https://github.com/krezh/containers/pkgs/container/whisparr-nightly) | nightly | ghcr.io/krezh/whisparr-nightly |![2](https://img.shields.io/badge/2-blue?style=flat-square) ![2.0](https://img.shields.io/badge/2.0-blue?style=flat-square) ![2.0.0](https://img.shields.io/badge/2.0.0-blue?style=flat-square) ![2.0.0.548](https://img.shields.io/badge/2.0.0.548-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-green?style=flat-square)


### Base Images

Container | Channel | Image | Latest Tags
--- | --- | --- | ---
[alpine](https://github.com/krezh/containers/pkgs/container/alpine) | 3.19 | ghcr.io/krezh/alpine |![3.19.4](https://img.shields.io/badge/3.19.4-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-green?style=flat-square)
[golang](https://github.com/krezh/containers/pkgs/container/golang) | bookworm | ghcr.io/krezh/golang |![1.23.4](https://img.shields.io/badge/1.23.4-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-green?style=flat-square)
[ubuntu](https://github.com/krezh/containers/pkgs/container/ubuntu) | jammy | ghcr.io/krezh/ubuntu |![jammy-20240911.1](https://img.shields.io/badge/jammy--20240911.1-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-green?style=flat-square)


## Contributing

1. Install [Docker](https://docs.docker.com/get-docker/), [Taskfile](https://taskfile.dev/) & [Cuelang](https://cuelang.org/)
2. Get familiar with the structure of the repositroy
3. Find a similar application in the apps directory
4. Copy & Paste an application and update the directory name
5. Update `metadata.yaml`, `Dockerfile`, `ci/latest.sh`, `ci/goss.yaml` and make it suit the application build
6. Include any additional files if required
7. Use Taskfile to build and test your image

    ```bash
    task APP=sonarr CHANNEL=main test
    ```

### Automated tags

Here's an example of how tags are created in the GitHub workflows, be careful with `metadata.json` as it does affect the outcome of how the tags will be created when the application is built.

| Application | Channel   | Stable | Base  | Generated Tag               |
|:-------------|:-----------|:--------:|:-------:|:-----------------------------|
| `ubuntu`    | `focal`   |  ✅  |  ✅ | `ubuntu:focal-19880312`     |
| `ubuntu`    | `focal`   |  ✅  |  ✅ | `ubuntu:focal-rolling`      |
| `alpine`    | `3.16`    |  ✅  |  ✅ | `alpine:rolling`            |
| `alpine`    | `3.16`    |  ✅  |  ✅ | `alpine:3.16.0`             |
| `sonarr`    | `main`    |  ✅  |  ❌ | `sonarr:3.0.8.1507`         |
| `sonarr`    | `main`    |  ✅  |  ❌ | `sonarr:rolling`            |
| `sonarr`    | `develop` |  ❌  |  ❌ | `sonarr-develop:3.0.8.1538` |
| `sonarr`    | `develop` |  ❌  |  ❌ | `sonarr-develop:rolling`    |

## Deprecations

Containers here can be **deprecated** at any point, this could be for any reason described below.

1. The upstream application is **no longer actively developed**
2. The upstream application has an **official upstream container** that follows closely to the mission statement described here
3. The upstream application has been **replaced with a better alternative**
4. The **maintenance burden** of keeping the container here **is too bothersome**

A lot of inspiration and ideas are thanks to the hard work of [onedr0p](https://github.com/onedr0p/), [hotio.dev](https://hotio.dev/) and [linuxserver.io](https://www.linuxserver.io/) contributors.
