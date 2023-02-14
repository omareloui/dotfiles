# Bootstrap

Bootstrap scripts to setup the dot files

## Available scripts

- `sym_config.sh`: sets up the config files and scripts. You can configure the
  files by changing up `FROM_ROOT` and `NOT_FROM_ROOT` in the file.
- `cp_udev.sh`: copies udev rules to their location.
- `install_packages.sh`: installs the packages from
  "$BOOTSTRAP_FILES/assets/packages.lst"

> For more information on each script run the script with the `--help` flag.

## Asset files

- `packages.lst`: used by the `install_packages.sh` script. To recreate it you
  can run `update_packageslist` it should exist on your path (after runing `sym_config.sh`).
- `udev/`: udev rules used by the `cp_udev.sh` script.
