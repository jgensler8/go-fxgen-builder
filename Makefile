
TAG=jgensl2/go-fxgen-builder
VERSION=v2.0.0
PACKAGE=github.com/jgensler8/go-fxgen-builder/example
FUNCTION=hello

package: docker docker_push

docker:
	docker build -t ${TAG}:${VERSION} .

docker_push:
	docker push ${TAG}:${VERSION}

test: docker
	docker run -it --rm -v $$PWD/example:/workdir -v $$PWD/output:/output -e PACKAGE=${PACKAGE} -e FUNCTION=${FUNCTION} ${TAG}:${VERSION}
