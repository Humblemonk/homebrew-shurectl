class Shurectl < Formula
  desc "Terminal UI configurator for Shure USB audio interfaces"
  homepage "https://github.com/Humblemonk/shurectl"
  url "https://github.com/Humblemonk/shurectl/archive/refs/tags/v2.6.2.tar.gz"
  sha256 "ac8d5e4bfb7c1e45433c95c5970c36e13a6a1861d0082a87454cf773bb14715b"
  license "GPL-3.0-only"
  head "https://github.com/Humblemonk/shurectl.git", branch: "main"

  depends_on "rust" => :build

  # macOS needs nothing at runtime: hidapi uses IOKit, cpal uses CoreAudio.
  # Linuxbrew needs ALSA for cpal and libudev for hidapi's linux-native
  # backend (device enumeration via the udev crate); both -sys crates locate
  # their libraries through pkg-config.
  on_linux do
    depends_on "pkgconf" => :build
    depends_on "alsa-lib"
    depends_on "systemd"
  end

  def install
    system "cargo", "install", *std_cargo_args
  end

  def caveats
    on_linux do
      <<~EOS
        Access to /dev/hidrawN requires a udev rule. See:
          #{homepage}#linux--udev-rules-required-for-non-root-access
      EOS
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/shurectl --version")
    # Passes with or without hardware attached: the no-device message is
    # "No supported Shure devices found."
    assert_match "Shure", shell_output("#{bin}/shurectl --list")
  end
end
