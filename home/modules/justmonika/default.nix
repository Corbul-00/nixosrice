{ pkgs ? import <nixpkgs> { } }:

pkgs.writeShellApplication {
  name = "justmonika";

  runtimeInputs = with pkgs; [
    coreutils
    findutils
    imv
    util-linux
  ];

  text = builtins.readFile ./justmonika.sh;
}
