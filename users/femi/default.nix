{ config, lib, pkgs, ... }:


with lib; {
  imports = [
    ./git.nix
    ./urxvt.nix
    ./emacs
    ./xresources
  ];

  femi = {
    urxvt.enable = true;
  };
}
