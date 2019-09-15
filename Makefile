export IMAGE_NAME?=rcarmo/docker-elastic
export BASE_IMAGE_NAME=debian:10
export VCS_REF=`git rev-parse --short HEAD`
export VCS_URL=https://github.com/rcarmo/docker-elastic
export BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"`
export TAG_DATE=`date -u +"%Y%m%d"`
export ELASTIC_VERSION=7.3.2
export TARGET_ARCHITECTURES=amd64
export SHELL=/bin/bash

# Permanent local overrides
-include .env

.PHONY: build qemu wrap push manifest clean

build:
	$(foreach ARCH, $(TARGET_ARCHITECTURES), make build-$(ARCH);)


translate-%: # translate our architecture mappings to s6's
	@if [[ "$*" == "arm32v7" ]] ; then \
	   echo "armhf"; \
	elif [[ "$*" == "arm64v8" ]] ; then \
	   echo "aarch64"; \
	else \
		echo $*; \
	fi 

build-%:
	$(eval ARCH := $*)
	docker build --build-arg BUILD_DATE=$(BUILD_DATE) \
		--build-arg ELASTIC_VERSION=$(ELASTIC_VERSION) \
		--build-arg BASE=$(BASE_IMAGE_NAME) \
		--build-arg VCS_REF=$(VCS_REF) \
		--build-arg VCS_URL=$(VCS_URL) \
		-t $(IMAGE_NAME):latest src
	@echo "--- Done building $(ARCH) ---"

push:
	docker push $(IMAGE_NAME)

push-%:
	$(eval ARCH := $*)
	docker push $(IMAGE_NAME):$(ARCH)


clean:
	-docker rm -fv $$(docker ps -a -q -f status=exited)
	-docker rmi -f $$(docker images -q -f dangling=true)
	-docker rmi -f $(BUILD_IMAGE_NAME)
	-docker rmi -f $$(docker images --format '{{.Repository}}:{{.Tag}}' | grep $(IMAGE_NAME))

