{ options, config, lib, pkgs, namespace, ... }:
with lib;
with lib.custom;
let
  inherit (config.lib.stylix) colors;
  cfg = config.cli.shells.fish;
in {
  options.cli.shells.zsh = with types; {
    enable = mkBoolOpt false "enable zsh shell";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ oh-my-zsh oh-my-posh ];

    programs = {
      oh-my-posh = {
        enable = true;
        useTheme = "json";
        enableZshIntegration = true;
      };
      zsh = {
        enable = true;
        syntaxHighlighting.enable = true;
        autocd = true;
        shellAliases = {
          c = "kitten cliboard copy";
          p = "kitten clipboard paste";
          ll = "ls -l";
          swc = "sudo nixos-rebuild switch --flake";
          hx = "helix";
          lg = "lazygit";
          flakec = "nix flake check";
        };
        autosuggestion.enable = true;
        oh-my-zsh = {
          enable = true;
          plugins = [ "git" "sudo" "docker" ];
        };
      };
    };
  };
}
