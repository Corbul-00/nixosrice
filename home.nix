{ config, pkgs, ... }: 

{
  home.username = "corbul";
  home.homeDirectory = "/home/corbul";
  
 
  imports = [
    ./home/modules/kitty/default.nix
    ./home/modules/hyprland/default.nix
    ./home/modules/waybar/default.nix
    #./home/modules/zsh/zsh.nix
  ];


  programs.zsh = {
	  enable = true;
	  oh-my-zsh = {
		  enable = true;
		  plugins = [
			  "git"
		  ];
	  };
	  plugins = [
	  {
		  name = "powerlevel10k";
		  src = pkgs.zsh-powerlevel10k;
		  file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
	  }
	  ];
	  initExtra = ''
		  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
		  '';
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
