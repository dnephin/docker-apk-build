
BUILD_ID ?= ${USER}


.PHONY: builder
builder:
	docker build -t apk_builder:${BUILD_ID} builder/

target:
	mkdir -p target
aports:
	git clone https://git.alpinelinux.org/aports

.PHONY: aports_update
aports_update: aports
	GIT_DIR=aports/.git git fetch origin -p
	GIT_DIR=aports/.git git pull origin master

user.abuild:
	mkdir -p user.abuild

build: builder target aports
	docker run -ti \
		-v ${PWD}/user.abuild/:/home/packager/.abuild \
		-v ${PWD}/aports:/work \
		-v ${PWD}/target:/target \
		-v ${HOME}/.gitconfig/:/home/packager/.gitconfig \
		apk_builder:${BUILD_ID} \
		sh

.PHONY: tester
tester:
	docker build -t apk_testing:${BUILD_ID} testing/

test: tester target
	docker run -ti \
		-v ${PWD}/target:/repo \
		-v ${PWD}/user.abuild/:/home/abuild/ \
		--privileged \
		apk_testing:${BUILD_ID}
