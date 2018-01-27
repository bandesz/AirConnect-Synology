REPO_REVISION=360408fb0de31b26c50c67ae8bda1940c2ece71c
VERSION=0.1.6.1

LICENSE:
	curl -s -L https://github.com/philippe44/AirConnect/raw/${REPO_REVISION}/LICENSE -O

package.tgz:
	curl -s -L https://github.com/philippe44/AirConnect/raw/${REPO_REVISION}/bin/airupnp-arm -O
	chmod +x airupnp-arm
	tar czf package.tgz airupnp-arm
	rm airupnp-arm

AirConnect-${VERSION}.spk:
	tar -czf AirConnect-${VERSION}.spk *

.PHONY: build
build: package.tgz LICENSE AirConnect-${VERSION}.spk
	@echo
	@echo "Build complete, install AirConnect-${VERSION}.spk through the Package Center"

.PHONY: clean
clean:
	rm -f package.tgz AirConnect*.spk LICENSE
