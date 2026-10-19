class Ecsterm < Formula
  desc "TUI to browse ECS clusters, services, containers and tasks and run the matching AWS CLI commands"
  homepage "https://github.com/aronjohanns/ecsterm"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aronjohanns/ecsterm/releases/download/v0.2.0/ecsterm-aarch64-apple-darwin.tar.xz"
      sha256 "4e7cd5e050ad8262ee4c96ab84d728b9647186c607a858600dd0a7784923c652"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aronjohanns/ecsterm/releases/download/v0.2.0/ecsterm-x86_64-apple-darwin.tar.xz"
      sha256 "11b8cf4b41dff4208b44346346585dcc0038eac9f4c6f2a186d8618400462a36"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/aronjohanns/ecsterm/releases/download/v0.2.0/ecsterm-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "dfe4b21e92c404eaeccee4fecab982337443f1f91d716b282450a539549959cd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aronjohanns/ecsterm/releases/download/v0.2.0/ecsterm-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4eaefa324661da4c73f6bd1ea3fa68fbb1eaa35772552cdb3b2b5f397ea80a56"
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
