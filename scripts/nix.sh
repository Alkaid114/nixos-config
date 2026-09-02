#!/usr/bin/env bash
set -euo pipefail

FLAKE="${FLAKE:-.}"
HOST="${HOST:-asus-tx5pro}"
USER="${USER:-alkaid}"
MNT="${MNT:-/mnt}"

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

BOLD=$'\033[1m'
CYAN=$'\033[36m'
RED=$'\033[31m'
RESET=$'\033[0m'

err() {
  printf "${RED}ERROR: %s${RESET}\n" "$*" >&2
}

usage() {
  cmd_name=$(basename "$0")
  section() { printf "\n${BOLD}%s${RESET}\n" "$1"; }
  entry() { printf "  ${CYAN}%-14s${RESET} %s\n" "$1" "$2"; }

  printf "Usage: %s <command> [args]\n" "$cmd_name"

  section "NixOS"
  entry switch "rebuild & switch to new generation"
  entry test "build but don't switch (activates in memory)"
  entry boot "rebuild & set as boot default"

  section "Home Manager"
  entry switch-hm "rebuild home-manager"
  entry test-hm "build & activate for current session only"
  entry build-hm "build without activating"

  section "Flake Management"
  entry update "update all flake inputs"
  entry update-input "update a specific input (usage: $cmd_name update-input <name>)"
  entry format "format all .nix files"
  entry check "evaluate flake & check for errors"
  entry show "show flake outputs"

  section "Store Maintenance"
  entry gc "garbage collect old generations"
  entry optimise "deduplicate nix store"

  section "LiveCD Deployment"
  entry copy-flake "copy flake to target (exclude .git, result, .direnv)"
  entry gen-hardware "generate hardware-config & write into this flake"
  entry check-hardware "verify mounts and hardware-config presence"
  entry confirm-mounts "verify mounts and confirm before continuing"
  entry install "check, confirm, copy, then install (run after gen-hardware)"

  section "Utility"
  entry help "show this help"

  printf "\nEnvironment variables: FLAKE (default: .), HOST (default: %s),\nUSER (default: %s), MNT (default: %s)\n" "$HOST" "$USER" "$MNT"
}

confirm_mounts() {
  if ! findmnt "$MNT" > /dev/null 2>&1; then
    err "$MNT is not a mount point. Mount your root partition to $MNT first."
    exit 1
  fi
  if findmnt -o FSTYPE -n "$MNT" | grep -q tmpfs; then
    err "$MNT is tmpfs (livecd root), not your target root. Mount your root partition first."
    exit 1
  fi

  echo ""
  echo "Mounts under $MNT:"
  findmnt -R "$MNT"
  echo ""
  echo "Disk info for mounted devices:"
  disks=$(sudo findmnt -R "$MNT" -o SOURCE -n | sort -u | \
    xargs -r lsblk -ndo PKNAME 2>/dev/null | sort -u)
  if [ -n "$disks" ]; then
    sudo lsblk -o NAME,MODEL,SIZE,TYPE,FSTYPE,MOUNTPOINT $disks
  fi
  echo ""
  printf "Confirm mounts are correct and continue? [y/N] "
  read -r ans
  case "$ans" in
    y|Y) ;;
    *) printf "Aborted.\n"; exit 1;;
  esac
}

check_hardware() {
  if ! findmnt "$MNT" > /dev/null 2>&1; then
    err "$MNT is not a mount point. Mount your root partition to $MNT first."
    exit 1
  fi
  if findmnt -o FSTYPE -n "$MNT" | grep -q tmpfs; then
    err "$MNT is tmpfs (livecd root), not your target root. Mount your root partition first."
    exit 1
  fi
  if [ ! -f "hosts/$HOST/.hardware-generated" ]; then
    err "Run '$0 gen-hardware' first to generate hardware configuration for this host."
    exit 1
  fi
}

cmd="${1:-}"
shift || true

case "$cmd" in
  # — NixOS —
  switch)
    sudo nixos-rebuild switch --flake "$FLAKE#$HOST"
    ;;
  test)
    sudo nixos-rebuild test --flake "$FLAKE#$HOST"
    ;;
  boot)
    sudo nixos-rebuild boot --flake "$FLAKE#$HOST"
    ;;

  # — Home Manager —
  switch-hm)
    home-manager switch --flake "$FLAKE#$USER"
    ;;
  test-hm)
    home-manager test --flake "$FLAKE#$USER"
    ;;
  build-hm)
    home-manager build --flake "$FLAKE#$USER"
    ;;

  # — Flake Management —
  update)
    nix flake update --flake "$FLAKE"
    ;;
  update-input)
    name="${1:-}"
    if [ -z "$name" ]; then
      err "update-input requires a name argument (usage: $0 update-input <name>)"
      exit 1
    fi
    nix flake lock --flake "$FLAKE" --update-input "$name"
    ;;
  format)
    nix fmt "$FLAKE"
    ;;
  check)
    nix flake check --flake "$FLAKE"
    ;;
  show)
    nix flake show "$FLAKE"
    ;;

  # — Store Maintenance —
  gc)
    sudo nix-collect-garbage -d && nix-collect-garbage -d
    ;;
  optimise)
    nix store optimise
    ;;

  # — LiveCD Deployment —
  copy-flake)
    sudo mkdir -p "$MNT/etc/nixos"
    sudo rsync -a --delete \
      --exclude=.git \
      --exclude=result \
      --exclude=.direnv \
      --exclude=.hardware-generated \
      "$REPO_ROOT/" "$MNT/etc/nixos/"
    ;;
  gen-hardware)
    confirm_mounts
    rm -f "hosts/$HOST/.hardware-generated"
    sudo nixos-generate-config --root "$MNT"
    sudo cat "$MNT/etc/nixos/hardware-configuration.nix" > "hosts/$HOST/hardware-configuration.nix"
    touch "hosts/$HOST/.hardware-generated"
    ;;
  check-hardware)
    check_hardware
    ;;
  confirm-mounts)
    confirm_mounts
    ;;
  install)
    check_hardware
    confirm_mounts
    "$0" copy-flake
    if [ ! -f "$MNT/etc/nixos/flake.nix" ]; then
      err "flake.nix not found at $MNT/etc/nixos/. copy-flake may have failed."
      exit 1
    fi
    sudo nixos-install \
      --root "$MNT" \
      --flake "$MNT/etc/nixos#$HOST"
    ;;

  # — Utility —
  help|-h|--help)
    usage
    ;;
  "")
    usage
    exit 1
    ;;
  *)
    err "unknown command: $cmd"
    echo ""
    usage
    exit 1
    ;;
esac
