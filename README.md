# Timer — Mac Menu Bar

A minimal stopwatch that lives in your macOS menu bar.

![macOS](https://img.shields.io/badge/macOS-13%2B-blue)
![Swift](https://img.shields.io/badge/Swift-5-orange)

## Features

- Stopwatch visible in the menu bar at all times
- Start, stop, and reset from the menu
- No dock icon, no window — purely menu bar

## Installation

### Download (recommended)

1. Go to [Releases](../../releases)
2. Download `timer.dmg`
3. Open the DMG and drag **timer.app** to your Applications folder
4. Right-click the app → **Open** (required once for unsigned builds)

### Build from source

Requires Xcode 15+.

```bash
git clone https://github.com/s2moon98/timer-mac-menu-bar.git
cd timer-mac-menu-bar
open timer.xcodeproj
```

Build and run with `Cmd+R`.

## Usage

Click the `⏱️ 00:00` icon in the menu bar to open the menu:

| Action | Description |
|--------|-------------|
| Start  | Begin the stopwatch |
| Stop   | Pause and reset to 00:00 |
| Quit   | Exit the app |

## Release

Releases are built automatically via GitHub Actions. To publish a new version:

```bash
git tag v1.0.0
git push origin v1.0.0
```

This triggers a build and uploads `timer.dmg` to GitHub Releases.
