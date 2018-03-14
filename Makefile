REPO_REVISION=5697465b3b6a9bd16e7b3308787132f39ee7d895
VERSION=0.2.0.5-$(shell date '+%Y%m%d')

LICENSE:
	curl -s -L https://github.com/philippe44/AirConnect/raw/${REPO_REVISION}/LICENSE -O

target:
	mkdir -p target

dist:
	mkdir -p dist

target/package.tgz: target
	$(if ${ARCH},,$(error Must specify ARCH))
	curl -s -L https://github.com/philippe44/AirConnect/raw/${REPO_REVISION}/bin/airupnp-${ARCH} -o target/airupnp
	chmod +x target/airupnp
	cd target && tar czf package.tgz airupnp
	rm target/airupnp

target/scripts: target
	cp -a scripts target

target/LICENSE: target
	curl -s -L https://github.com/philippe44/AirConnect/raw/${REPO_REVISION}/LICENSE -o target/LICENSE

target/INFO: target
	$(if ${INFO_ARCH},,$(error Must specify INFO_ARCH))
	$(if ${INFO_FIRMWARE},,$(error Must specify INFO_FIRMWARE))
	cp INFO target/INFO
	sed -i '' -e 's/#INFO_ARCH#/${INFO_ARCH}/' target/INFO
	sed -i '' -e 's/#INFO_FIRMWARE#/${INFO_FIRMWARE}/' target/INFO

dist/AirConnect-${ARCH}-${VERSION}.spk: target/package.tgz target/scripts target/LICENSE target/INFO dist
	$(if ${ARCH},,$(error Must specify ARCH))
	cd target && tar -czf AirConnect-${ARCH}-${VERSION}.spk *
	mv target/AirConnect-${ARCH}-${VERSION}.spk dist/

.PHONY: arm
arm:
	$(eval export INFO_ARCH=ipq806x armada370 armadaxp armada375 armada38x alpine alpine4k monaco comcerto2k)
	$(eval export INFO_FIRMWARE=5.0-4458)
	@true

.PHONY: x86
x86:
	$(eval export INFO_ARCH=x86 cedarview bromolow evansport avoton braswell broadwell apollolake)
	$(eval export INFO_FIRMWARE=5.0-4458)
	@true

.PHONY: x86-64
x86-64:
	$(eval export INFO_ARCH=x86_64)
	$(eval export INFO_FIRMWARE=6.0-7321)
	@true

.PHONY: build
build: ${ARCH} dist/AirConnect-${ARCH}-${VERSION}.spk

.PHONY: clean
clean:
	rm -rf target

.PHONY: clean-dist
clean-dist:
	rm -rf dist

.PHONY: build-all
build-all: clean-dist
	./build.sh

.PHONY: shellcheck
shellcheck:
	shellcheck -s sh scripts/*
