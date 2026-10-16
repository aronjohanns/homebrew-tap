class Baosign < Formula
  desc "Sign SSH keys with OpenBao, using profiles like aws --profile"
  homepage "https://github.com/aronjohanns/baosign"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aronjohanns/baosign/releases/download/v0.2.0/baosign-aarch64-apple-darwin.tar.xz"
      sha256 "16d883683175725f64dcbc806ecbecc6aec935640232d47eca0b490209fa355c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aronjohanns/baosign/releases/download/v0.2.0/baosign-x86_64-apple-darwin.tar.xz"
      sha256 "8b8c38532afeb505f7093d65d4d98650207731bc9fb39396022703811f6f4207"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/aronjohanns/baosign/releases/download/v0.2.0/baosign-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "264cee8d4e7b24a3f4bbfdecf4b93014262c00d486e3805635b6bb04fb8326ff"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aronjohanns/baosign/releases/download/v0.2.0/baosign-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8337416cb2d1978f0775ba88cdc552543757b777794ecbbca38d06cca3551167"
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
