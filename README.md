# gipomarchy: Arch Linux System Optimization & Workflow Toolkit

This repository is a personal system configuration and optimization toolkit for Arch Linux, serving as a backup and experimentation ground for the author's omarchy setup. It provides scripts and utilities for system tuning, power management, and workflow automation.

## Key Components

- **`optimization.sh`**: Main system optimization script. Sets up ZRAM, swapfile, sysctl tuning, inotify limits, SSD trim, and power profiles. **Run as root.**

- **`omarchy bin/powerprofiles-list`**: Bash utility to list available power profiles using `powerprofilesctl`, highlighting the active one.

- **This README**: Contains troubleshooting notes, configuration snippets, and personal workflow tips.

## Usage & Workflows

### System Optimization

Run after system changes or fresh installs:

```bash
sudo bash optimization.sh
```

### Power Profile Management

List and verify current power profiles:

```bash
./omarchy\ bin/powerprofiles-list
```

Set a profile:

```bash
powerprofilesctl set balanced
```

### Customization & Experimentation

Scripts are designed for direct editing and experimentation. No formal test/build system is present. Update scripts and notes in-place for new hardware or troubleshooting.

## Project Conventions

- Bash scripts, intended for direct execution on Arch Linux.

- Paths and commands may assume root privileges and specific system tools (`powerprofilesctl`, `systemctl`, etc.).

- No package management or dependency installation is automated—manual setup is expected.

- The `omarchy bin/` directory is used for custom utility scripts.

## Integration Points

- Relies on standard Linux utilities: `systemctl`, `sysctl`, `powerprofilesctl`, `fstrim`, etc.

- No external APIs or network dependencies.

## Examples

- **Run optimization:**

  ```bash
  sudo bash optimization.sh
  ```

- **List power profiles:**

  ```bash
  ./omarchy\ bin/powerprofiles-list
  ```

- **Set power profile:**

  ```bash
  powerprofilesctl set balanced
  ```

## Troubleshooting & Notes

- For launching the Cursor app with Wayland/Electron flags:

  ```bash
  ELECTRON_OZONE_PLATFORM_HINT=wayland cursor --use-gl=desktop \
    --enable-features=UseOzonePlatform,WaylandWindowDecorations \
    --ozone-platform-hint=wayland
  ```

- This repo is not intended for general-purpose use—scripts are tailored to the author's hardware and preferences.

- For questions or unclear conventions, review this README or ask the repository owner.

---

Original dotfiles: [arch-gip](https://github.com/Ghifaryh/arch-gip)
