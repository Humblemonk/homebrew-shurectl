class Shurectl < Formula
  desc "Terminal UI configurator for Shure USB audio interfaces"
  homepage "https://github.com/Humblemonk/shurectl"
  url "https://github.com/Humblemonk/shurectl/archive/refs/tags/v2.6.0.tar.gz"
  sha256 "ac2f7bdcae4f4df9ce6c2aad8c9aca31c38dbc2df68dc436839db67251e343cc"
  license "GPL-3.0-only"
  head "https://github.com/Humblemonk/shurectl.git", branch: "main"

  depends_on "rust" => :build

  # macOS needs nothing at runtime: hidapi uses IOKit, cpal uses CoreAudio.
  # Linuxbrew needs ALSA headers for cpal; hidapi's linux-native backend
  # talks to /dev/hidrawN directly and needs no system library.
  on_linux do
    depends_on "alsa-lib"
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
