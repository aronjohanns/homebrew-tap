class Baosign < Formula
  desc "Sign SSH keys with OpenBao, using profiles like aws --profile"
  homepage "https://github.com/aronjohanns/baosign"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aronjohanns/baosign/releases/download/v0.2.1/baosign-aarch64-apple-darwin.tar.xz"
      sha256 "a37ab7ba3309dfff6408a6e57caf939de6feb9034a474df375f3e69e5e5efa43"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aronjohanns/baosign/releases/download/v0.2.1/baosign-x86_64-apple-darwin.tar.xz"
      sha256 "955ce11a9f9df958b226c00018c01c45e59f7f6d3c59e31dd988e5fd46d435a8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/aronjohanns/baosign/releases/download/v0.2.1/baosign-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2b6bde62fd9ab3f01756e4d97183d48eb2a0c2b2c317bb383b5174dad13a2ba6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aronjohanns/baosign/releases/download/v0.2.1/baosign-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e4b6d1ea269dcdf1cf53a1637e30cf28fdc8d69ee3c466f1ee0cb5d05336fc51"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "baosign"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "baosign"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "baosign"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "baosign"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
