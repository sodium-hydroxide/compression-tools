PREFIX ?= /usr/local

.PHONY: install uninstall

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
