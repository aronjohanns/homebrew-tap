class Baosign < Formula
  desc "Sign SSH keys with OpenBao, using profiles like aws --profile"
  homepage "https://github.com/aronjohanns/baosign"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aronjohanns/baosign/releases/download/v0.3.0/baosign-aarch64-apple-darwin.tar.xz"
      sha256 "6a8e2792f0238a975395fd2c6a618964c6125e7648b473ce1a0eaa62340d4fcc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aronjohanns/baosign/releases/download/v0.3.0/baosign-x86_64-apple-darwin.tar.xz"
      sha256 "c181a880fde2326cb93f9dba9aa63bff63b6b2fa78fd17851dcc4e83a5744654"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/aronjohanns/baosign/releases/download/v0.3.0/baosign-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f07fbba4fb72291259f0859296f1246d6705e570fdfa93654a5c3e8708253b17"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aronjohanns/baosign/releases/download/v0.3.0/baosign-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f670d49d9abd5081e76b9e3704042f6f6743a36482720bfcb310ee7ccad0db95"
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
