class Baosign < Formula
  desc "Sign SSH keys with OpenBao, using profiles like aws --profile"
  homepage "https://github.com/aronjohanns/baosign"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aronjohanns/baosign/releases/download/v0.1.0/baosign-aarch64-apple-darwin.tar.xz"
      sha256 "e5a302f5bd8fa87f73b830bae7d707bc531ae44dd838588d36b3573f953556c5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aronjohanns/baosign/releases/download/v0.1.0/baosign-x86_64-apple-darwin.tar.xz"
      sha256 "e399bc6906beb5f88a4527f93b8aaf22d7f6e458140b2f52d234b6f7a7811f2b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/aronjohanns/baosign/releases/download/v0.1.0/baosign-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cc989f0e7257f9cf6bab80ffde518b19a3ce92ae08c9525aae5939506e43f052"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aronjohanns/baosign/releases/download/v0.1.0/baosign-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3aa62f63858b47f4e23c759938e7268c88b2bac32f50488c9e219675f752e0fe"
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
