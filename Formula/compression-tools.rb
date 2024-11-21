class CompressionTools < Formula
  desc "Collection of utilities for file compression operations"
  homepage "https://github.com/sodium-hydroxide/compression-tools"
  url "https://github.com/sodium-hydroxide/compression-tools/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "d3f82798679a02e1c2e93a648bd26d06747a8b23a4f638ebf1b7732fac3b0d1f"
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
