#!/bin/bash

IMG=$(buildah from registry.access.redhat.com/ubi8/ubi-minimal:8.2)

buildah run "${IMG}" -- mkdir /build
buildah copy "${IMG}" ./config/my-app.conf /build/my-app.conf

buildah run "${IMG}" -- echo APP_VERSION="${1}" >> /build/my-app.conf

buildah copy "${IMG}" ./script.sh /build/script.sh

buildah config --entrypoint '[ "/build/script.sh" ]' $IMG

buildah commit "${IMG}" buildah-example