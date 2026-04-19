{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    # Enables OMZ framework + plugins
    ohMyZsh = {
      enable = true;
      plugins = [ "git" ];                     # add more later: docker, kubectl, etc.
      # theme = "powerlevel10k/powerlevel10k"; # we'll set this manually below
    };

    # Still enable these – they work nicely together with OMZ
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Your custom syntax highlight colors (still needed)
    initExtraBeforeCompInit = ''
      ZSH_HIGHLIGHT_STYLES[command]='fg=165,bold'
      ZSH_HIGHLIGHT_STYLES[alias]='fg=165,bold'
      ZSH_HIGHLIGHT_STYLES[builtin]='fg=165,bold'
      ZSH_HIGHLIGHT_STYLES[precommand]='fg=165,bold'

      ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=44'
      ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=44'
      ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=44'
    '';

    # Your aliases (move them here so they survive rebuilds)
    shellAliases = {
      ls  = "lsd";
      l   = "ls -l";
      la  = "ls -a";
      lla = "ls -la";
      lt  = "ls --tree";
      # ... all your other aliases
    };

    # History settings
    history = {
      size = 50000;
      save = 50000;
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
    };
  };

  # fzf integration (very useful with OMZ)
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # Packages you probably want
  home.packages = with pkgs; [
    zsh-powerlevel10k
    meslo-lgs-nf
    lsd
    fastfetch
    # pokemon-colorscripts   # if you use it
  ];
}
