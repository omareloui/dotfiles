{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  pkg-config,
  qt6,
  bluez,
  dbus,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "sony-device-center";
  version = "0.1.4";

  src = fetchFromGitHub {
    owner = "marconvcm";
    repo = "sony-device-center";
    tag = "v${finalAttrs.version}";
    hash = "sha256-Yd4H4/03VNDPgqRGJ8QYSLBgJY0izowVUz49tHEpp/4=";
  };

  # The legacy ImGui `Client` target builds automatically (pulling in glfw/imgui)
  # whenever its CMakeLists exists. We only want the Qt app + daemon + CLI, but the
  # Client directory still holds the Linux Bluetooth connector sources that
  # sony-transport compiles directly, so drop only the add_subdirectory call.
  postPatch = ''
    substituteInPlace CMakeLists.txt \
      --replace-fail 'add_subdirectory(Client)' '# add_subdirectory(Client) removed for Nix build'
  '';

  nativeBuildInputs = [
    cmake
    pkg-config
    qt6.wrapQtAppsHook
  ];

  buildInputs = [
    qt6.qtbase
    qt6.qtdeclarative # provides Qml, Quick, QuickControls2
    bluez # libbluetooth
    dbus
  ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DBUILD_TESTING=OFF"
  ];

  meta = {
    description = "Cross-platform companion app to manage Sony audio devices (GUI + sonyd daemon + sonyctl CLI)";
    homepage = "https://github.com/marconvcm/sony-device-center";
    license = lib.licenses.mit;
    mainProgram = "sony-device-center";
    platforms = lib.platforms.linux;
  };
})
