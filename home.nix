{ config, pkgs, ... }: 

{
  home.username = "corbul";
  home.homeDirectory = "/home/corbul";
  
 
  imports = [
    ./home/modules/kitty/default.nix
    ./home/modules/hyprland/default.nix
    ./home/modules/waybar/pink.nix
    ./home/modules/fish/default.nix
    ./home/modules/gtk/default.nix # Comment: Added global GTK theme configuration.
    ./home/modules/fastfetch/default.nix
    ./home/modules/btop/default.nix
    ./home/modules/librewolf/default.nix
    ./home/modules/lazyvim/default.nix
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

  #Hyprland
  #programs.waybar.enable = true;
  #programs.swww.enable = true;

  #Homestate (DO NOT CHANGE)
  home.stateVersion = "25.11";
}
