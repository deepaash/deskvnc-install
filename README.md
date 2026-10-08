# DeskVNC install helper

One-line install commands for [DeskVNC](https://github.com/psmux/DeskVNC), the
native desktop client for **VNC, RDP and SSH** written in Rust on Tauri 2.
DeskVNC ships an MCP server (`dvv`) that lets an AI agent drive a remote
session while a person can take control back at any moment.

The latest stable release is **v0.27.11**. Every command below points at the
real assets on the [release page](https://github.com/psmux/DeskVNC/releases/tag/v0.27.11).

## macOS

```sh
brew tap deepaash/homebrew-deskvnc
brew install --cask deskvnc
```

That installs **DeskVNCViewer.app** into `/Applications` from the universal
disk image. The community tap is
[`deepaash/homebrew-deskvnc`](https://github.com/deepaash/homebrew-deskvnc).

If you prefer to fetch the disk image directly, the verified artifact is
[`DeskVNCViewer_0.27.11_universal.dmg`](https://github.com/psmux/DeskVNC/releases/download/v0.27.11/DeskVNCViewer_0.27.11_universal.dmg).

## Windows

Download the signed installer
[`DeskVNCViewer_0.27.11_x64-setup.exe`](https://github.com/psmux/DeskVNC/releases/download/v0.27.11/DeskVNCViewer_0.27.11_x64-setup.exe)
from the [release page](https://github.com/psmux/DeskVNC/releases/tag/v0.27.11)
and run it. The installer is signed by Open Source Developer Godwin Josh
(Certum).

A Microsoft Installer variant is also available:
[`DeskVNCViewer_0.27.11_x64_en-US.msi`](https://github.com/psmux/DeskVNC/releases/download/v0.27.11/DeskVNCViewer_0.27.11_x64_en-US.msi).

## Linux

The release ships native packages for `x86_64` and a portable AppImage. The
install command depends on your distribution. The helper script below prints
the right one for your machine.

```sh
curl -fsSL https://raw.githubusercontent.com/deepaash/deskvnc-install/main/install.sh | sh
```

Direct downloads from the release page:

- Debian or Ubuntu:
  [`DeskVNCViewer_0.27.11_amd64.deb`](https://github.com/psmux/DeskVNC/releases/download/v0.27.11/DeskVNCViewer_0.27.11_amd64.deb)
- Fedora, RHEL, AlmaLinux, Rocky, or openSUSE:
  [`DeskVNCViewer-0.27.11-1.x86_64.rpm`](https://github.com/psmux/DeskVNC/releases/download/v0.27.11/DeskVNCViewer-0.27.11-1.x86_64.rpm)
- AppImage (runs from anywhere):
  [`DeskVNCViewer_0.27.11_amd64.AppImage`](https://github.com/psmux/DeskVNC/releases/download/v0.27.11/DeskVNCViewer_0.27.11_amd64.AppImage)

## Register the `dvv` MCP server

DeskVNC ships the `dvv` MCP server alongside the GUI. After install, the
binary lives at one of these locations depending on the platform:

- macOS: `/Applications/DeskVNCViewer.app/Contents/MacOS/dvv`
- Windows: `%LOCALAPPDATA%\DeskVNCViewer\dvv.exe` or
  `C:\Program Files\DeskVNCViewer\dvv.exe`
- Linux: `/usr/bin/dvv`

Register `dvv` with your MCP client and an AI agent can open a saved
machine, observe the screen and send clicks and keystrokes over the
ordinary VNC, RDP or SSH connection, with nothing installed on the
remote machine, and a person can take control back at any moment.

The four-call loop with the MCP tools:

```jsonc
dvv_hosts   {}
dvv_open    {"hostId": "<id>", "perceive": true}
dvv_control {"limbId": "...", "action": "acquire"}
dvv_screen  {"limbId": "...", "form": "full", "scale": 0.25}
dvv_click   {"limbId": "...", "x": 700, "y": 400, "generation": 1}
dvv_type    {"limbId": "...", "text": "notepad", "wpm": 3000}
dvv_key     {"limbId": "...", "keys": "meta+r"}
```

The shell equivalent, after `dvv setup`:

```sh
dvv hosts
dvv open <name or hostId> --perceive
dvv wait <limbId> --until connected
dvv control acquire <limbId>
dvv screen <limbId> --scale 0.5 --out ./dvv-screen.png
dvv click <limbId> <x> <y>
dvv type <limbId> "text to type"
dvv key <limbId> super+r
dvv close <limbId>
```

## Uninstall

```sh
curl -fsSL https://raw.githubusercontent.com/deepaash/deskvnc-install/main/uninstall.sh | sh
```

## Where the project lives

The upstream project is at <https://github.com/psmux/DeskVNC>. Issues, ideas
and pull requests go there. This repository is a thin install helper maintained
by the community.
