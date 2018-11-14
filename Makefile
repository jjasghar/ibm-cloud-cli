IMAGE := jjasghar/ibm-cloud-cli
VERSION:= $(shell grep IBM_CLOUD_CLI Dockerfile | awk '{print $2}' | cut -d '=' -f 2)

test:
	true

image:
	docker build -t ${IMAGE}:${VERSION} .
	docker tag ${IMAGE}:${VERSION} ${IMAGE}:latest

push-image:
	docker push ${IMAGE}:${VERSION}
	docker push ${IMAGE}:latest


.PHONY: image push-image test
