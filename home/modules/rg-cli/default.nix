{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "rg-cli";
  version = "0.1.0";

  src = ./rg-cli;

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/rg-cli
    chmod +x $out/bin/rg-cli
  '';

  meta = {
    description = "Fast, lightweight RedGIFs search, batch downloader, and mpv player CLI";
    mainProgram = "rg-cli";
  };
}
