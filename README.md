# Compression Utilities

A collection of shell utilities for file compression operations.

## Tools

- `compress-files`: Compresses all files in the current directory using gzip
- `decompress-files`: Decompresses all .gz files in the current directory (excluding .tar.gz)

## Installation

```bash
make install
```

To install to a different location:
```bash
make install PREFIX=/your/custom/path
```

Installation can also be done using `homebrew` with the following commands:

```bash
brew tap sodium-hydroxide/compression-tools https://github.com/sodium-hydroxide/compression-tools
brew install sodium-hydroxide/compression-tools/compression-tools 
```

## Usage

Both tools support the --help flag for usage information:

```bash
compress-files --help
decompress-files --help
```

