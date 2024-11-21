class CompressionTools < Formula
  desc "Collection of utilities for file compression operations"
  homepage "https://github.com/sodium-hydroxide/compression-tools"
  url "https://github.com/yourusername/compression-utils/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "HASH_HERE" # You'll need to generate this after creating the release
  license "MIT"

  def install
    # Install binaries and shared code
    bin.install Dir["bin/*"]
    prefix.install "src"
    
    # Update the source path in the binary files
    inreplace Dir[bin/"*"] do |s|
      s.gsub! "../src", prefix/"src"
    end
  end

  test do
    # Test both utilities
    assert_match "Usage: compress-files", shell_output("#{bin}/compress-files --help")
    assert_match "Usage: decompress-files", shell_output("#{bin}/decompress-files --help")
  end
end