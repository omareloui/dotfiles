# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a NixOS dotfiles repository managed as a flake, containing both system (NixOS) and user (Home Manager) configurations. The repository supports multiple hosts (dell, zenbook, ocd, nyx) with shared and host-specific configurations.

## Key Commands

### Building and Switching Configurations

```bash
# Build NixOS configuration (without activation)
nh os build

# Switch to new NixOS configuration
nh os switch

# Build Home Manager configuration (without activation)
nh home build

# Switch to new Home Manager configuration
nh home switch

# Update flake inputs
cd ~/.dotfiles && nix flake update

# Garbage collection (both user and system)
nix-collect-garbage -d && sudo nix-collect-garbage -d
```

### Testing Configurations

```bash
# Build specific host configuration
nix build .#nixosConfigurations.nyx.config.system.build.toplevel

# Build specific home-manager configuration
nix build .#homeConfigurations."omareloui@nyx".activationPackage

# Check flake
nix flake check
```

### Development Workflow

```bash
# Edit dotfiles in neovim
edot  # alias that cd's to $FLAKE and opens in $EDITOR

# List system generations
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# List home-manager generations
home-manager generations
```

## Repository Architecture

### Directory Structure

- **flake.nix**: Main entry point defining all configurations and dependencies
- **hosts/**: NixOS system configurations
  - `common/`: Shared system configuration modules
    - `global/`: Core system settings (nix, locale, packages, ssh, etc.)
    - `optional/`: Optional modules (bluetooth, boot, hardware, homelab, qmk, etc.)
    - `users/`: User-specific system configurations
  - `<hostname>/`: Host-specific configurations (dell, zenbook, ocd, nyx)
- **home/**: Home Manager configurations
  - `omareloui/`: User configurations
    - `global/`: Base home-manager setup with overlays and nix-colors
    - `features/cli/`: CLI tools (git, zsh, nvim, zellij, yazi, etc.)
    - `features/desktop/`: Desktop environment (hyprland, kitty, gtk, qt, etc.)
    - `<hostname>.nix`: Host-specific home configurations
- **pkgs/**: Custom packages and scripts
  - Custom utilities: `vol`, `brightness`, `wallpaper`, `screenshot`, `cloud_backup`, etc.
  - Bar utilities: `init_bar`, `bar_themeswitcher`
  - Battery utility: `batwarning`
  - Session management: `zj_sessions` (Zellij sessions)
- **overlays/**: Nixpkgs overlays
  - `additions`: Custom packages from `pkgs/`
  - `modifications`: Package modifications
  - `stable-packages`: Access to stable nixpkgs channel
- **secrets/**: SOPS-encrypted secrets

### Configuration Flow

1. **NixOS configurations** (`nixosConfigurations` in flake.nix):
   - Import host-specific config from `hosts/<hostname>/`
   - Host configs import from `hosts/common/global/` and `hosts/common/optional/`
   - System-level settings, services, and base packages

2. **Home Manager configurations** (`homeConfigurations` in flake.nix):
   - Standalone home-manager (not as NixOS module)
   - Import `home/omareloui/global/` for base setup
   - Import `home/omareloui/features/cli/` and optionally `features/desktop/`
   - User packages, dotfiles, and services

### Key Flake Inputs

- `nixpkgs`: Primary package source (nixos-unstable)
- `nixpkgs-stable`: Stable channel packages (accessible as `pkgs.stable.<package>`)
- `home-manager`: User environment management
- `hyprland`, `hyprlock`, `hypridle`, `hyprpicker`: Wayland compositor suite
- `neovim-nightly`: Nightly neovim builds
- `nix-colors`: Color scheme management
- `sops-nix`: Secret management
- `catppuccin`: Catppuccin theme integration
- `nvim-config`: External neovim configuration (github:omareloui/nvim)

### Theme System

The configuration supports light/dark theme switching via specialisations:

```bash
# Toggle between light and dark themes
toggle-theme

# Switch to specific theme
toggle-theme dark
toggle-theme light

# List available specialisations
specialisation list
```

### Custom Package Development

Custom packages in `pkgs/` follow the pattern:

- Each package in its own directory with `default.nix`
- Exported through `pkgs/default.nix`
- Added to overlays via `overlays/default.nix`
- Available in system as `pkgs.<package-name>`

When adding new custom packages:

1. Create directory in `pkgs/<package-name>/`
2. Add `default.nix` with package derivation
3. Export in `pkgs/default.nix`

### Important Environment Variables

- `FLAKE`: Path to dotfiles (default: `~/.dotfiles`)
- `NH_FLAKE`: Used by `nh` tool (same as `FLAKE`)
- `MYHOME`: Custom home directory structure (`~/myhome`)
- `EDITOR`: Set to `nvim`

### NixOS Hosts

- **nyx**: Main desktop (Hyprland, Docker, Bluetooth, homelab services)
- **ocd**: WSL configuration (NixOS-WSL)
- **zenbook**: Laptop configuration
- **dell**: Desktop configuration (not currently in use)

All hosts share common configuration from `hosts/common/` but can override or extend as needed.
