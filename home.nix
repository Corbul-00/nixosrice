{ config, pkgs, ... }: 

{
  home.username = "corbul";
  home.homeDirectory = "/home/corbul";
  
 
  imports = [
    ./home/modules/kitty/pink.nix
    ./home/modules/hyprland/pink.nix
    ./home/modules/waybar/pink.nix
    ./home/modules/fish/default.nix
    ./home/modules/gtk/pink.nix # Comment: Added global GTK theme configuration.
    ./home/modules/fastfetch/pink.nix
    ./home/modules/btop/default.nix
    ./home/modules/librewolf/default.nix
    ./home/modules/lazyvim/default.nix
    ./home/modules/mangohud/default.nix
    ./home/modules/yazi/pink.nix
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
