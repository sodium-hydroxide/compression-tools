#!/bin/bash

# Shared function to display compress script usage
show_compress_usage() {
    echo "Usage: compress-files"
    echo "Compresses all files in the current directory using gzip"
    echo "Compressed files will have .gz extension added"
    echo "Original files will be removed after successful compression"
}

# Shared function to display decompress script usage
show_decompress_usage() {
    echo "Usage: decompress-files"
    echo "Decompresses all .gz files in the current directory"
    echo "Skips .tar.gz files to prevent archive corruption"
    echo "Original .gz files will be removed after successful decompression"
}

# Shared function for compression
compress_directory_contents() {
    # Check if any files exist in the directory
    if [ -z "$(ls -A)" ]; then
        echo "Error: No files found in current directory"
        return 1
    fi

    # Initialize counters
    local compressed=0
    local errors=0

    # Process each file in the current directory
    for file in *; do
        # Skip if it's a directory or already a .gz file
        if [ -d "$file" ] || [[ "$file" == *.gz ]]; then
            continue
        fi
        
        # Try to compress the file
        if gzip -f "$file"; then
            echo "Successfully compressed: $file"
            ((compressed++))
        else
            echo "Error compressing: $file"
            ((errors++))
        fi
    done

    # Display summary
    echo -e "\nCompression complete:"
    echo "$compressed files compressed successfully"
    if [ $errors -gt 0 ]; then
        echo "$errors files failed to compress"
        return 1
    fi

    return 0
}

# Shared function for decompression
decompress_directory_contents() {
    # Check if any .gz files exist in the directory
    if ! ls *.gz >/dev/null 2>&1; then
        echo "Error: No .gz files found in current directory"
        return 1
    fi

    # Initialize counters
    local decompressed=0
    local errors=0
    local skipped=0

    # Process each .gz file in the current directory
    for file in *.gz; do
        # Skip .tar.gz files
        if [[ "$file" == *.tar.gz ]]; then
            echo "Skipping tar archive: $file"
            ((skipped++))
            continue
        fi

        # Try to decompress the file
        if gunzip -f "$file"; then
            echo "Successfully decompressed: $file"
            ((decompressed++))
        else
            echo "Error decompressing: $file"
            ((errors++))
        fi
    done

    # Display summary
    echo -e "\nDecompression complete:"
    echo "$decompressed files decompressed successfully"
    if [ $skipped -gt 0 ]; then
        echo "$skipped .tar.gz files skipped"
    fi
    if [ $errors -gt 0 ]; then
        echo "$errors files failed to decompress"
        return 1
    fi

    return 0
}

