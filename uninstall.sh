#!/usr/bin/env bash
# DeskVNC uninstall helper
# Detects the operating system and prints the removal command the user
# should run. Nothing is removed by this script. The user stays in
# control.
set -euo pipefail

OS=$(uname -s)
ARCH=$(uname -m)

case "$OS" in
  Darwin)
    printf '\nDetected macOS on %s.\n\n' "$ARCH"
    cat <<MSG
Remove the cask with Homebrew:

  brew uninstall --cask deskvnc
  brew untap deepaash/homebrew-deskvnc

If you installed from the disk image, also remove the app:

  rm -rf /Applications/DeskVNCViewer.app
MSG
    ;;
  Linux)
    printf '\nDetected Linux on %s.\n\n' "$ARCH"
    cat <<MSG
Remove the package with the same package manager that installed it.

Debian or Ubuntu:

  sudo apt remove deskvncviewer
  sudo apt autoremove

Fedora, RHEL, AlmaLinux, Rocky, or openSUSE:

  sudo dnf remove DeskVNCViewer

AppImage:

  rm DeskVNCViewer_0.27.11_amd64.AppImage
  # and remove the file you copied it to, if any
MSG
    ;;
  *)
    printf '\nDetected an unsupported platform: %s on %s.\n\n' "$OS" "$ARCH"
    cat <<MSG
No removal steps are known for this platform. See the upstream project
for guidance:

  https://github.com/psmux/DeskVNC
MSG
    exit 1
    ;;
esac
