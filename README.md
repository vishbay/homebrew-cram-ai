# homebrew-cram-ai

Homebrew tap for [cram-ai](https://github.com/vishbay/cram-ai) — cut AI coding token costs by 96-98%.

## Install

```bash
brew tap vishbay/cram-ai
brew trust vishbay/cram-ai   # required: Homebrew 5.x tap trust
brew install cram-ai
```

## Usage

```bash
cram --help          # CLI reference
cram-menu            # launch tray popup (macOS menu bar)
```

### Autostart tray at login

```bash
brew services start vishbay/cram-ai/cram-ai
```

### Stop autostart

```bash
brew services stop vishbay/cram-ai/cram-ai
```

## Extras

The formula installs `cram-ai[tray,mcp]`:

| Extra | Packages installed |
|---|---|
| `tray` | pystray, Pillow, pywebview, Flask |
| `mcp` | mcp (Claude Code / agent MCP server) |

## Uninstall

```bash
brew uninstall cram-ai
brew untap vishbay/cram-ai
```
