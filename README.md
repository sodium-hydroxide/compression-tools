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

## Usage

Both tools support the --help flag for usage information:

```bash
compress-files --help
decompress-files --help
```

