{
  lib,
  stdenvNoCC,
  fetchzip,
  writeShellApplication,
  makeDesktopItem,
  copyDesktopItems,
  icoutils,
  coreutils,
  wineWow64Packages,
  winetricks,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ultimate-software-8bitdo";
  version = "1.37";

  src = fetchzip {
    url = "https://support.8bitdo.com/bd-uploads/files/ultimate_soft/8BitDo_Ultimate_Software_V2_Windows_V${finalAttrs.version}.zip";
    hash = "sha256-aob3RWsSB2JuZLrroK1ku6NA5eHCRVBoJYNukNV1N4M=";
  };

  launcher = writeShellApplication {
    name = "ultimate-software-8bitdo";
    runtimeInputs = [coreutils wineWow64Packages.stable winetricks];
    text = lib.replaceStrings ["@version@" "@appSrc@"] [finalAttrs.version "${finalAttrs.src}"] (builtins.readFile ./launcher.sh);
  };

  nativeBuildInputs = [copyDesktopItems icoutils];

  desktopItems = [
    (makeDesktopItem {
      name = "ultimate-software-8bitdo";
      desktopName = "8BitDo Ultimate Software V2";
      comment = "Configure and update 8BitDo controllers";
      exec = "ultimate-software-8bitdo";
      icon = "ultimate-software-8bitdo";
      categories = ["Game" "Utility"];
    })
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    ln -s ${finalAttrs.launcher}/bin/ultimate-software-8bitdo $out/bin/

    # Let the logged-in user talk to 8BitDo devices (vendor 2dc8) over hidraw/usb,
    # including the bootloader mode used for firmware updates.
    mkdir -p $out/lib/udev/rules.d
    cat > $out/lib/udev/rules.d/70-8bitdo.rules <<'RULES'
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="2dc8", MODE="0660", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="2dc8", MODE="0660", TAG+="uaccess"
    RULES

    wrestool -x -t 14 "8BitDo Ultimate Software V2.exe" -o app.ico
    icotool -x app.ico
    for png in app_*.png; do
      size=$(echo "$png" | sed -E 's/.*_([0-9]+)x[0-9]+x[0-9]+\.png/\1/')
      install -Dm644 "$png" "$out/share/icons/hicolor/''${size}x''${size}/apps/ultimate-software-8bitdo.png"
    done

    runHook postInstall
  '';

  meta = {
    description = "8BitDo Ultimate Software V2 running under Wine";
    homepage = "https://app.8bitdo.com/Ultimate-Software-V2/";
    license = lib.licenses.unfree;
    sourceProvenance = [lib.sourceTypes.binaryNativeCode];
    mainProgram = "ultimate-software-8bitdo";
    platforms = ["x86_64-linux"];
  };
})
