{ config, pkgs, ... }: 

{
  home.username = "corbul";
  home.homeDirectory = "/home/corbul";
  
 
  imports = [
     # Select exactly ONE complete visual profile here.
    # ./home/themes/default.nix
    # ./home/themes/pink.nix
    ./home/themes/hyprlain.nix

    ./home/modules/fish/default.nix
    #./home/modules/fastfetch/default.nix
    ./home/modules/btop/default.nix
    ./home/modules/librewolf/default.nix
    ./home/modules/lazyvim/default.nix
    ./home/modules/mangohud/default.nix
    ./home/modules/yazi/default.nix
    ./home/modules/eza/default.nix
    ./home/modules/termusic/default.nix
    ./home/modules/grabber/default.nix
    ./home/modules/stash/default.nix
  ];


  #Cursor

  home.pointerCursor = {
  name = "Frieren"; # Tem que bater com o nome da pasta (mkdir) criada acima
  package = pkgs.callPackage ./home/modules/frieren/default.nix {};
  size = 24;
  gtk.enable = true;
  x11.enable = true;
  };


  #Basic Neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  #Default Browser
  
  home.sessionVariables = {
    DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
    BROWSER = "${pkgs.firefox}/bin/firefox";
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = [ "firefox.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
      "x-scheme-handler/about" = [ "firefox.desktop" ];
      "x-scheme-handler/unknown" = [ "firefox.desktop" ];
    };
  };

  #Hyprland
  #programs.waybar.enable = true;
  #programs.swww.enable = true;

  #Homestate (DO NOT CHANGE)
  home.stateVersion = "25.11";
}
