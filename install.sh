#!/usr/bin/env bash
# DeskVNC install helper
# Detects the operating system and architecture and prints the install
# command the user should run. Nothing is downloaded and nothing is
# installed by this script. The user stays in control.
set -euo pipefail

OS=$(uname -s)
ARCH=$(uname -m)

VERSION="0.27.11"
RELEASE_URL="https://github.com/psmux/DeskVNC/releases/tag/v${VERSION}"

case "$OS" in
  Darwin)
    printf '\nDetected macOS on %s.\n\n' "$ARCH"
    cat <<MSG
Install with the community Homebrew tap:

  brew tap deepaash/homebrew-deskvnc
  brew install --cask deskvnc

Or fetch the universal disk image directly:

  curl -LO https://github.com/psmux/DeskVNC/releases/download/v${VERSION}/DeskVNCViewer_${VERSION}_universal.dmg
  open DeskVNCViewer_${VERSION}_universal.dmg

Release page: ${RELEASE_URL}
MSG
    ;;
  Linux)
    printf '\nDetected Linux on %s.\n\n' "$ARCH"
    cat <<MSG
Download the package for your distribution from the release page and run
the matching install command.

Release page: ${RELEASE_URL}

Debian or Ubuntu (amd64):

  curl -LO https://github.com/psmux/DeskVNC/releases/download/v${VERSION}/DeskVNCViewer_${VERSION}_amd64.deb
  sudo apt install ./DeskVNCViewer_${VERSION}_amd64.deb
  sudo apt-get install -f

Fedora, RHEL, AlmaLinux, Rocky, or openSUSE (x86_64):

  curl -LO https://github.com/psmux/DeskVNC/releases/download/v${VERSION}/DeskVNCViewer-${VERSION}-1.x86_64.rpm
  sudo dnf install ./DeskVNCViewer-${VERSION}-1.x86_64.rpm

AppImage (no install required, runs from anywhere):

  curl -LO https://github.com/psmux/DeskVNC/releases/download/v${VERSION}/DeskVNCViewer_${VERSION}_amd64.AppImage
  chmod +x DeskVNCViewer_${VERSION}_amd64.AppImage
  ./DeskVNCViewer_${VERSION}_amd64.AppImage
MSG
    ;;
  *)
    printf '\nDetected an unsupported platform: %s on %s.\n\n' "$OS" "$ARCH"
    cat <<MSG
DeskVNC ships native packages for macOS, Windows and Linux. See the
release page for the latest downloads and install instructions.

  ${RELEASE_URL}
MSG
    exit 1
    ;;
esac
