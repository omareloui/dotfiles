# Dotfiles

All dotfiles I use and need. And more on [starting up an new distro](./settings-up-new-distro.md).

---

## Download and Install

Clone this repository in your home directory.

```bash
git clone git@github.com:omareloui/dotfiles.git
```

To install the configuration all you have to do is to run the `install_dotfiles.sh` file.

```bash
chmod +x install.sh
./install_dotfiles.sh
```

## Included configuration

- `nvim`
- `fish`
- `git`
- List in `./packages.txt` for all installed apt packages.

  To update this list run `./list_packages.sh` script.

---

## License

MIT.
