{ config, pkgs, lib, ... }:

with lib; {
  imports = [
    ./users
  ];

  options.femi = {
    git = {
      name = mkOption {
        type = types.str;
        default = "Femi Agbabiaka";
        example = "Femi Agbabiaka";
        description = "Name to use with git commits.";
      };
      email = mkOption {
        type = types.str;
        default = "femi@femiagbabiaka.xyz";
        example = "femi@femiagbabiaka.xyz";
        description = "Email to go with git commits.";
      };
    };
  };

  config = {
    boot.cleanTmpDir = true;

    environment.systemPackages = with pkgs; [ emacs ];

    nix = {
      autoOptimiseStore = true;
      useSandbox = true;

      trustedUsers = [ "root" "femi" ];
    };

    nixpkgs.config = {
      allowUnfree = true;
    };

    services.journald.extraConfig = ''
      SystemMaxUse=100M
      MaxFileSec=7day
    '';

    services.resolved = {
      enable = true;
      dnssec = "false";
    };
  };

}
