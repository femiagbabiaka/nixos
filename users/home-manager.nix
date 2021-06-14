{config, pkgs, ...}:

{
  imports = [ <home-manager/nixos> ];

  home-manager.users.femi = (import ./femi);
}
