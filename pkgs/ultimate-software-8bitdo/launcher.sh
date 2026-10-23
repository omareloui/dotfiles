# Runs 8BitDo Ultimate Software V2 inside its own Wine prefix.
# The app writes next to its executable (configs, auto-update data), so it is
# copied out of the read-only store into the prefix and refreshed on upgrade.

export WINEPREFIX="${ULTIMATE_SOFTWARE_8BITDO_PREFIX:-${XDG_DATA_HOME:-$HOME/.local/share}/8bitdo-ultimate-software}"
export WINEDEBUG="${WINEDEBUG:--all}"
# The app ships its own .NET runtime; skip the Mono/Gecko install prompts.
export WINEDLLOVERRIDES="${WINEDLLOVERRIDES:-mscoree,mshtml=}"

appdir="$WINEPREFIX/drive_c/8BitDo Ultimate Software V2"

if [ ! -f "$WINEPREFIX/system.reg" ]; then
  mkdir -p "$WINEPREFIX"
  wineboot --init
  wineserver --wait
fi

# Without the MS core fonts the app crashes on startup.
if [ ! -f "$WINEPREFIX/.corefonts-installed" ]; then
  winetricks --unattended corefonts
  touch "$WINEPREFIX/.corefonts-installed"
fi

if [ "$(cat "$WINEPREFIX/.app-version" 2>/dev/null)" != "@version@" ]; then
  rm -rf "$appdir"
  cp -r --no-preserve=mode "@appSrc@" "$appdir"
  echo "@version@" >"$WINEPREFIX/.app-version"
fi

cd "$appdir"
exec wine "8BitDo Ultimate Software V2.exe" "$@"
