
BUILD_ID ?= ${USER}


.PHONY: builder
builder:
	docker build -t apk_builder:${BUILD_ID} builder/

work:
	mkdir -p work
target:
	mkdir -p target
user.abuild:
	mkdir -p user.abuild

build: work target builder
	docker run -ti \
		-e PACKAGE_NAME \
		-v ${PWD}/user.abuild/:/home/packager/.abuild \
		-v ${PWD}/work:/work \
		-v ${PWD}/target:/target \
		-v ${HOME}/.gitconfig/:/home/packager/.gitconfig \
		apk_builder:${BUILD_ID} \
		sh
