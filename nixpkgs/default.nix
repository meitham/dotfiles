# default.nix
let
  pkgs = self;

  homies = with pkgs;
    [
      # Customized packages
      bashrc
      git
      tmux
      vim

      # Sourced directly from Nixpkgs
      pkgs.curl
      pkgs.htop
      pkgs.nix
      pkgs.pass
      pkgs.tree
      pkgs.xclip
    ];


in homies
