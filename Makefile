LICENSE:
	curl -L https://github.com/philippe44/AirConnect/raw/master/LICENSE -O

package.tgz:
	curl -L https://github.com/philippe44/AirConnect/raw/master/bin/airupnp-arm -O
	tar czf package.tgz airupnp-arm
	rm airupnp-arm

AirConnect.spk:
	tar -czf AirConnect.spk *

.PHONY: build
build: package.tgz AirConnect.spk LICENSE

.PHONY: clean
clean:
	rm -f package.tgz AirConnect.spk LICENSE
