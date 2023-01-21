# Bootstrap

Bootstrap scripts to setup the dot files

## Available scripts

- `scripts.sh`: sets up the custom scripts I use (symlinks them to ~/.local/bin).
- `config.sh`: sets up the config files you can configure the files by changing up
`FROM_ROOT` and `NOT_FROM_ROOT` in the file.
- `battery.sh` sets up the required assets for battery scripts and battery cron
jobs note that you'll need to add the cron jobs yourself [read more](../docs/battery.md).

- `utils.sh`: utilities script used by other scripts.

- Assets scripts: you can read more about them [here](./assets/README.md).
- Package and application scripts: you can read more about them [here](./packages/README.md).

### Common Arguments

For `scripts.sh`, `config.sh`, and `battery.sh` you have:

- `-h` or `--help`: for more information.
- `-v` or `--verbose` to log more information during running the script.
