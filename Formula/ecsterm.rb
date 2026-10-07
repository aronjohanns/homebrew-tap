class Ecsterm < Formula
  desc "TUI to browse ECS clusters, services, containers and tasks and run the matching AWS CLI commands"
  homepage "https://github.com/aronjohanns/ecsterm"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aronjohanns/ecsterm/releases/download/v0.1.1/ecsterm-aarch64-apple-darwin.tar.xz"
      sha256 "51b24f2acd8e5c57c716e8470578c44545c7e2d9739770e0c597e96b0b5748a4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aronjohanns/ecsterm/releases/download/v0.1.1/ecsterm-x86_64-apple-darwin.tar.xz"
      sha256 "7d0be09574585f294f9b2ad9a9b555103ad4a0dd3787e339179ca5400944ea21"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/aronjohanns/ecsterm/releases/download/v0.1.1/ecsterm-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "03721366d0b7e403c97ec4f8e0ea563c60b0dafc4588dc2dc569d638e07efaef"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aronjohanns/ecsterm/releases/download/v0.1.1/ecsterm-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "808e79e4915901cf8969533057c843eef383d804c2faed00a92107702d494db7"
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
      bin.install "ecsterm"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "ecsterm"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "ecsterm"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "ecsterm"
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
