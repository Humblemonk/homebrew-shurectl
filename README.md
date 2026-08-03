# homebrew-shurectl

Homebrew tap for [shurectl](https://github.com/Humblemonk/shurectl) — a terminal UI
configurator for Shure MOTIV USB audio interfaces and Microphones (MVX2U Gen 1/2, MV6, MV7+).

## Install

```bash
brew install humblemonk/shurectl/shurectl
```

Updates come through `brew upgrade` like any other formula.

The formula builds from source, so the first install pulls in a Rust toolchain and takes a
minute or two. There are no runtime dependencies on macOS.

## Usage

```bash
shurectl                         # Connect to first detected device and launch TUI
shurectl --device <path>         # Connect to a specific device (use --list to find paths)
shurectl --demo                  # Run without a device (explore the UI)
shurectl --list                  # List detected Shure devices and exit
shurectl --mute                  # Toggle mute without launching the TUI
shurectl --mute on               # Mute
shurectl --mute off              # Unmute
```

See the [main repository](https://github.com/Humblemonk/shurectl) for full documentation,
keyboard shortcuts, and protocol details.

## Reporting issues

File bugs against the [main repository](https://github.com/Humblemonk/shurectl/issues), not
this one — this repo contains only the packaging formula.

## License

The formula is released under the same terms as shurectl itself: GPL-3.0-only.
