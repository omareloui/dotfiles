{
  stdenv,
  fetchFromGitHub,
  python312,
}:
stdenv.mkDerivation {
  pname = "inkscape-applytransforms";
  version = "0.pre+unstable=2021-05-11";

  src = fetchFromGitHub {
    owner = "Klowner";
    repo = "inkscape-applytransforms";
    rev = "5b3ed4af0fb66e399e686fc2b649b56db84f6042";
    sha256 = "XWwkuw+Um/cflRWjIeIgQUxJLrk2DLDmx7K+pMWvIlI=";
  };

  nativeCheckInputs = [
    python312.pkgs.inkex
    python312.pkgs.pytestCheckHook
  ];

  dontBuild = true;

  doCheck = true;

  installPhase = ''
    runHook preInstall

    install -Dt "$out/share/inkscape/extensions" *.inx *.py

    runHook postInstall
  '';
}
