{ config, pkgs, lib, ... }:

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = (builtins.fromTOML (builtins.readFile ./starship.toml)) // {
      nix_shell = {
        impure_msg = "";
        format = "via [$symbol$name]($style) ";
      };
    };
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.skim = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      # Remove a mensagem de boas vindas
      set -U fish_greeting

      # Direnv
      set -gx DIRENV_LOG_FORMAT ""

      # Keybind do fzf
      bind \cf fzf-cd-widget

      # Cores do LS
      set -x LS_COLORS "di=1;94:ln=1;36:so=1;35:pi=1;33:ex=1;97:bd=1;38;5;110:cd=1;38;5;110:su=1;31:sg=1;31:tw=1;34:ow=1;34:fi=38;5;67:*.md=38;5;67:*.c=1;36:*.rb=1;36:*.ele=1;36:*.el=1;36:*.ipynb=1;36:*.py=1;36:*.cpp=1;1;36:*.rs=1;36:*.lua=1;36:*.log=38;5;:*.str=92:"

      
    '';

    shellAliases = {
      myfetch = "fastfetch";
      # Seus aliases convertidos
      cd = "z";
      cat = "bat --paging=never --style=plain --color=always";
      vimconfig = "cd /etc/nixos/nvim/ && nvim";
      nixconfig = "cd /etc/nixos/ && nvim";
      hdmount = "sudo mkdir -p /run/media/corbul/Data && sudo mount -t ntfs-3g -o rw,uid=1000,gid=1000,umask=000,windows_names /dev/sda1 /run/media/corbul/Data";
      hdumount = "sudo umount /run/media/corbul/Data";
      ls = "eza --icons --group-directories-first --color=always --git --time-style=long-iso";
      vi = "nvim";
      ec = "emacsclient -n";

      # Aliases solicitados na migração
      #grep = "rg";
      fzf = "sk"; 

      # O alias tm (tmuxinator) foi desativado. 
      # Se quiser gerenciar sessões no Zellij, você pode usar layouts KDL.
      # tm = "zellij --layout"; 
    #} // {
    #  sudo = "doas";
    };

    # Funções do Fish no formato Nix
    functions = {
      inv = ''
        set query $argv
        nvim (fzf -m --query="$query" --preview="bat --color=always {}")
      '';

      temple = ''
        cd ~/Documents/Oracle\'s\ Temple
      '';

      neofetch = ''
        fastfetch --logo-type kitty-direct --logo ~/.config/makotoicon.png --logo-width 45 --logo-height 20
      '';

      github = ''
        cd ~/Documents/GitHub
      '';
      fish_title = "";
    };
  };

  # Variáveis de ambiente
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # Adicionando pastas ao PATH
  home.sessionPath = [
    "$HOME/.local/bin"
  ];
}
