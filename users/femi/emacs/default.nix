{ config, pkgs, ... }:

{
  programs.emacs.enable = true;
  services.emacs.enable = true;

  home.file.".emacs.d/init.el".source = ./init.el;

  home.file."bin/e" = {
    text = ''
      #!/bin/sh
      emacsclient -a "" -nc $@
    '';
    executable = true;
  };
}
