# buildah lab

This repo contains a live sample about how to build images using buildah with both the dockerfile format and the "command mode".

## usage

to build, run:

```bash
make dockerfile buildah
```

to test the images, run:

```bash
make run
```

to save the images on the disk:

```bash
make export-all
```

to (try to) import on containerd:

```bash
make import-in-containerd
```

### quick start

to simulate the problem all at once, just run:

```bash
make all
```

## test environment

```bash
➜ buildah --version
buildah version 1.15.1 (image-spec 1.0.1-dev, runtime-spec 1.0.2-dev)
➜ podman --version
podman version 2.0.4
➜ ctr --version
ctr github.com/containerd/containerd 1.3.3-0ubuntu2
```