{pkgs}: {
  name,
  version,
  src,
  cargoLock ? null,
  cargoHash ? null,
  buildInputs ? [],
  nativeBuildInputs ? [],
}:
pkgs.rustPlatform.buildRustPackage {
  pname = name;
  inherit version src cargoLock;

  cargoHash =
    if cargoLock == null
    then cargoHash
    else null;

  buildInputs = [pkgs.openssl] ++ buildInputs;
  nativeBuildInputs = [pkgs.pkg-config] ++ nativeBuildInputs;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/lib
    cp target/x86_64-unknown-linux-gnu/release/lib${name}.so $out/lib/
    runHook postInstall
  '';

  doCheck = false;
}
