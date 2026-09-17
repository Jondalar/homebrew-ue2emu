# Source formula: Homebrew builds the tagged release with cargo. The emulator is a niche developer tool, so a few
# minutes of compiling on install beat maintaining per-platform release binaries.
class Ue2emu < Formula
  desc "Emulator for Ultimate 64 Elite II and C64 Ultimate firmware"
  homepage "https://github.com/Jondalar/UE2-C64U-Emulator"
  url "https://github.com/Jondalar/UE2-C64U-Emulator/archive/refs/tags/v0.3.2.tar.gz"
  sha256 "1dc63fee32721a8fd73e4af1b5705dbaea6f509463e34712fb625f717e3df2fc"
  license "GPL-3.0-or-later"
  head "https://github.com/Jondalar/UE2-C64U-Emulator.git", branch: "main"

  depends_on "rust" => :build
  depends_on "libslirp"

  on_linux do
    depends_on "pkgconf" => :build
    depends_on "alsa-lib"
  end

  def install
    # crates/ue2-net/build.rs links libslirp from here.
    ENV["SLIRP_LIB_DIR"] = Formula["libslirp"].opt_lib
    system "cargo", "install", *std_cargo_args(path: "crates/ue2emu")
    system "cargo", "install", *std_cargo_args(path: "crates/ue2-mcp")
  end

  def caveats
    <<~EOS
      No firmware and no ROMs are included. Boot your own ultimate.elf or .ue2 update file:
        ue2emu run --firmware /path/to/update.ue2 --flash ~/ue2emu/flash.bin

      MCP server for Claude Code:
        claude mcp add ue2emu -- #{opt_bin}/ue2-mcp

      Usage: https://github.com/Jondalar/UE2-C64U-Emulator/blob/main/docs/status/install.md
    EOS
  end

  test do
    assert_match "ue2emu #{version}", shell_output("#{bin}/ue2emu --version")
    assert_match "ue2-mcp #{version}", shell_output("#{bin}/ue2-mcp --version")
  end
end
