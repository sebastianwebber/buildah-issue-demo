PROJECT_DIR=$(shell pwd)

### usualy the git tag from the command line
BUILD_VERSION="$(shell git branch --show-current)"

TARGET_FOLDER="$(PROJECT_DIR)/target/images"

export-image:
	buildah push \
		--format docker \
		$(IMAGE_NAME):latest \
		docker-archive:$(TARGET_FOLDER)/docker-$(IMAGE_NAME)-$(BUILD_VERSION).tar
	buildah push \
		--format oci \
		$(IMAGE_NAME):latest \
		oci-archive:$(TARGET_FOLDER)/oci-$(IMAGE_NAME)-$(BUILD_VERSION).tar

export-all:
	rm -rf $(TARGET_FOLDER)
	mkdir -p $(TARGET_FOLDER)
	make IMAGE_NAME=dockerfile-example export-image
	make IMAGE_NAME=buildah-example export-image

import-in-containerd:
	bash -x import-images.sh

dockerfile:
	buildah build-using-dockerfile \
		--format docker \
		--file Dockerfile \
		--volume $(PROJECT_DIR)/config/:/config \
		--tag dockerfile-example:latest \
		--build-arg BUILD_VERSION=$(BUILD_VERSION)
		$(BUILDAH_EXTRA_OPTS) .

buildah:
	bash -x buildah-builder.sh $(BUILD_VERSION)

execute:
	podman run -it --rm buildah-example:latest


manually:
	BASE_IMAGE="$(shell buildah from registry.access.redhat.com/ubi8/ubi-minimal:8.2)"
	echo "$(BASE_IMAGE)"

all: buildah dockerfile export-all import-in-containerd

clean:
	rm -rf $(TARGET_FOLDER)
	podman image rm -a -f

run:
	podman run -it --rm buildah-example:latest
	podman run -it --rm dockerfile-example:latest