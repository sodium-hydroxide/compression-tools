PREFIX ?= /usr/local
VERSION := $(shell cat VERSION.txt)

.PHONY: install uninstall release check-version

install:
	install -d $(PREFIX)/bin
	install -m 755 bin/compress-files $(PREFIX)/bin/compress-files
	install -m 755 bin/decompress-files $(PREFIX)/bin/decompress-files
	install -d $(PREFIX)/share/compression-utils
	install -m 644 src/compression_utils.sh $(PREFIX)/share/compression-utils/compression_utils.sh

uninstall:
	rm -f $(PREFIX)/bin/compress-files
	rm -f $(PREFIX)/bin/decompress-files
	rm -rf $(PREFIX)/share/compression-utils

check-version:
	@if [ -z "$(VERSION)" ]; then \
		echo "Usage: make release VERSION=x.y.z"; \
		exit 1; \
	fi
	@CURRENT_VERSION=$$(cat VERSION.txt); \
	if ! echo "$$CURRENT_VERSION\n$(VERSION)" | sort -C -V; then \
		echo "Error: New version ($(VERSION)) must be greater than current version ($$CURRENT_VERSION)"; \
		exit 1; \
	fi

release: check-version
	@if git diff-index --quiet HEAD --; then \
		VERSION_TAG="v$(VERSION)"; \
		echo "$(VERSION)" > VERSION.txt; \
		git add VERSION.txt; \
		git commit -m "Bump version to $(VERSION)"; \
		git tag -a $$VERSION_TAG -m "Release $$VERSION_TAG"; \
		git push origin main; \
		git push origin $$VERSION_TAG; \
		sleep 2; \
		SHA256=$$(curl -L "https://github.com/sodium-hydroxide/compression-tools/archive/refs/tags/$$VERSION_TAG.tar.gz" | shasum -a 256 | awk '{print $$1}'); \
		sed -i '' "s/sha256 \".*\"/sha256 \"$$SHA256\"/" Formula/compression-tools.rb; \
		git add Formula/compression-tools.rb; \
		git commit -m "Update SHA256 for $$VERSION_TAG"; \
		git push origin main; \
		echo "Release $$VERSION_TAG complete!"; \
		echo "SHA256: $$SHA256"; \
	else \
		echo "Error: Working directory not clean. Commit changes first."; \
		exit 1; \
	fi
