class Shurectl < Formula
  desc "Terminal UI configurator for Shure USB audio interfaces"
  homepage "https://github.com/Humblemonk/shurectl"
  url "https://github.com/Humblemonk/shurectl/archive/refs/tags/v2.9.0.tar.gz"
  sha256 "3db5cb2223bd322e5048b2445236d22a809e9fa1b957981113444bec8b2a9036"
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
