# homebrew-ue2emu

Homebrew tap for [UE2-C64U-Emulator](https://github.com/Jondalar/UE2-C64U-Emulator), an emulator for Ultimate 64
Elite II / C64 Ultimate firmware.

```sh
brew install jondalar/ue2emu/ue2emu
```

The formula builds the tagged release from source (Rust, libslirp) and installs two binaries:

- `ue2emu`: the emulator (`ue2emu run --help`, `ue2emu install --help`).
- `ue2-mcp`: the MCP server for automated testing; register it with `claude mcp add ue2emu -- $(brew --prefix)/bin/ue2-mcp`.

No firmware and no ROMs are included. Usage: [docs/status/install.md](https://github.com/Jondalar/UE2-C64U-Emulator/blob/main/docs/status/install.md).
