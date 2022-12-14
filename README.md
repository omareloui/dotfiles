# Dotfiles

All dotfiles I use and need, and more on [setting up a new distro](./settings-up-new-distro.md).

---

## Download and Install

Clone this repository in your home directory.

```bash
git clone git@github.com:omareloui/dotfiles.git
```

To install the configuration all you have to do is to run the `scripts/install_dotfiles.sh` file.

```bash
cd ~/dotfiles

chmod +x scripts/install_dotfiles.sh
./scripts/install_dotfiles.sh
```

## Included configuration

- VS Code
- `nvim`
- `fish`
- `git`
- `starship`
- List in `./packages.txt` of all installed apt packages.

  To update this list run `./scripts/list_packages.sh`.

---

## License

MIT.
