# AGENTS.md — nixdotfiles

## Repo structure

```
flake.nix               # Entrypoint: defines 3 nixosConfigurations (x86_64-linux)
hosts/<name>/           # Per-host config (imports modules/core + hardware-configuration.nix)
modules/core/           # NixOS modules: boot, hardware, home-manager, lemp, locale, networking,
                        #   printers, steam, system, user, vm, services, wayland, kubernetes
modules/home/           # home-manager modules (integrated as NixOS module, not standalone)
modules/home/modules/   # bash, dunst, fonts, git, gtk, hypr, nvim, kubernetes, packages,
                        #   services, spicetify, starship, steam, xdg
```

## Hosts

| Host        | Hardware              | Status |
|-------------|-----------------------|--------|
| Kurohikari  | ThinkPad T480 (laptop)| Active, stable |
| Kuroha      | Desktop PC            | WIP    |
| Kagami      | VM                    | WIP    |

## Key commands

```bash
# Build and switch to a configuration
sudo nixos-rebuild switch --flake .#<Kurohikari|Kuroha|Kagami>

# Update all flake inputs
nix flake update

# Update a single input
nix flake lock --update-input <name>

# Install prerequisites for install.sh
nix-shell -p git gum
```

## Architecture notes

- Username `Shiroe` is hardcoded in `flake.nix:46` and passed as `specialArgs` to all configurations.
- home-manager is integrated as a **NixOS module** (`modules/core/home-manager.nix`), not standalone. Uses `useUserPackages = true; useGlobalPkgs = true;`.
- Per-host conditional logic uses `lib.mkIf (host == "...")` in home-manager and services modules.
- Custom module options are defined per-module (e.g. `steam.enable`, `vm.enable`, `wayland.enable`, `kube.enable`, `printers.enable`, `lemp.enable`).
- `host` is passed as `specialArgs` from `flake.nix` — do not rename this arg.
- Hardware configs live in `hosts/<name>/hardware-configuration.nix`. The `install.sh` script copies from `/etc/nixos/hardware-configuration.nix`.
- Install script is interactive (`gum` TUI) — for unattended use, run the rebuild command directly.
- Flake state version: `"26.05"` (system), `"26.05"` (home-manager).
- Editor config: `.luarc.json` disables `redundant-parameter` and `unused-local` diagnostics, registers `vim` and `csvview` as globals for Lua/LuaLS.

## Other

- Origin GitHub: `github.com/1101101011/nixdotfiles` — user is `1101101011`.
- License: MIT.
