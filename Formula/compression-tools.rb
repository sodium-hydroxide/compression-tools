class CompressionTools < Formula
  desc "Collection of utilities for file compression operations"
  homepage "https://github.com/sodium-hydroxide/compression-tools"
  url "https://github.com/sodium-hydroxide/compression-tools/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
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
