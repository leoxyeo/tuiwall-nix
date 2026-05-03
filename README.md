# tuiwall-nix

A Nix Flake for [tuiwall](https://github.com/Mug-Costanza/tuiwall), a CLI wallpaper engine for the terminal that creates customizable split-pane headers in `tmux`.

## 🚀 Quick Start

Run `tuiwall` instantly without installing it:

```bash
nix run github:leoxyeo/tuiwall-nix
```

## 🛠 Installation

### 1. Nix Profile
To install it to your user profile:

```bash
nix profile install github:leoxyeo/tuiwall-nix
```

### 2. NixOS Configuration (Flakes)
Add this repository to your `flake.nix` inputs:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    tuiwall.url = "github:leoxyeo/tuiwall-nix";
  };

  outputs = { self, nixpkgs, tuiwall, ... }: {
    nixosConfigurations.your-hostname = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit tuiwall; };
      modules = [
        ./configuration.nix
      ];
    };
  };
}
```

Then, add it to your `systemPackages` in `configuration.nix`:

```nix
{ pkgs, tuiwall, ... }: {
  environment.systemPackages = [
    tuiwall.packages.${pkgs.system}.default
  ];
}
```

## 📦 Dependencies Included
This flake automatically wraps `tuiwall` with the following runtime dependencies:
- `tmux`
- `git`
- `gh` (GitHub CLI)
- `vhs`
- `python3`

## ⚖️ License
The Nix packaging is licensed under the MIT License. The `tuiwall` source code is subject to its own [original license](https://github.com/Mug-Costanza/tuiwall/blob/main/LICENSE.md).
