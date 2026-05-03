# tuiwall-nix

Nix flake for [tuiwall](https://github.com/Mug-Costanza/tuiwall) — a tmux-based terminal wallpaper engine.

## Quick Start

```bash
nix run github:leoxyeo/tuiwall-nix
```

## Installation

### Nix Profile

```bash
nix profile install github:leoxyeo/tuiwall-nix
```

### NixOS (via overlay — recommended)

In your `flake.nix`:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    tuiwall-nix.url = "github:leoxyeo/tuiwall-nix";
  };

  outputs = { self, nixpkgs, tuiwall-nix, ... }: {
    nixosConfigurations.your-hostname = nixpkgs.lib.nixosSystem {
      modules = [
        { nixpkgs.overlays = [ tuiwall-nix.overlays.default ]; }
        ./configuration.nix
      ];
    };
  };
}
```

Then in `configuration.nix`:

```nix
{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.tuiwall ];
}
```

### NixOS (via nixosModule — one-liner)

Adds tuiwall to `systemPackages` automatically:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    tuiwall-nix.url = "github:leoxyeo/tuiwall-nix";
  };

  outputs = { self, nixpkgs, tuiwall-nix, ... }: {
    nixosConfigurations.your-hostname = nixpkgs.lib.nixosSystem {
      modules = [
        tuiwall-nix.nixosModules.default
        ./configuration.nix
      ];
    };
  };
}
```

## Dependencies

All runtime dependencies are automatically injected via `wrapProgram`:

| Package | Purpose |
|---------|---------|
| `tmux` | Core dependency - manages split-pane sessions |
| `git` | Fetching and managing preset repositories |
| `python3` | Running preset scripts (stdlib only) |
| `gh` | `tuiwall upload/search` - community features |
| `vhs` | `tuiwall record` - recording demo GIFs |
