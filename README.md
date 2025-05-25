<div align="center">

## Containers

_An opinionated collection of container images_

</div>

<div align="center">

[![Release](https://img.shields.io/github/actions/workflow/status/krezh/containers/release.yaml?branch=main&style=for-the-badge&logo=github&logoColor=white&color=blue&label=%20)](https://github.com/krezh/containers/actions/workflows/release.yaml)
[![Renovate](https://img.shields.io/github/actions/workflow/status/krezh/renovate-config/renovate.yaml?branch=main&style=for-the-badge&logo=renovate&logoColor=white&color=blue&label=%20)](https://github.com/krezh/renovate-config/actions/workflows/renovate.yaml)

</div>

## Rootless

To run these containers as non-root make sure you update your configuration to the user and group you want.

## Available Images

Images can be [browsed on the GitHub Packages page for this repo's packages](https://github.com/krezh?tab=packages&repo_name=containers).

## Configuration volume

For applications that need to have persistent configuration data the config volume is hardcoded to `/config` inside the container. This is not able to be changed in most cases.

## Deprecations

Containers here can be **deprecated** at any point, this could be for any reason described below.

1. The upstream application is **no longer actively developed**
2. The upstream application has an **official upstream container** that follows closely to the mission statement described here
3. The upstream application has been **replaced with a better alternative**
4. The **maintenance burden** of keeping the container here **is too bothersome**

## Credits

A lot of inspiration and ideas are thanks to the hard work of the home-ops community, [hotio.dev](https://hotio.dev/) and [linuxserver.io](https://www.linuxserver.io/) contributors.
