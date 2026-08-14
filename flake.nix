{	
  description = "WaifuRoom NixBTW";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    lazyvim-nix.url = "github:pfassina/lazyvim-nix";  # <-- ADD THIS
    
    hyprlain = {
      url = "github:Ascaniolamp/Hyprlain/ffb81b75911562085ca802e9f4e66cab4bb6e872";
      flake = false;
    };

    nix-doom-emacs-unstraightened = {
        url = "github:marienz/nix-doom-emacs-unstraightened";
        inputs.nixpkgs.follows = "nixpkgs";
      };

  };
   
  outputs = { self, nixpkgs, home-manager, lazyvim-nix, hyprlain, nix-doom-emacs-unstraightened, ... }:
  let
    system = "86_64-linux";
    in {
      nixosConfigurations.waifuroom = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
	  home-manager.nixosModules.home-manager
	  {
	   home-manager.useGlobalPkgs = true;
	   home-manager.useUserPackages = true; 
	   home-manager.users.corbul = import ./home.nix;
	   home-manager.backupFileExtension = "backup";
	   home-manager.extraSpecialArgs = { inherit lazyvim-nix hyprlain nix-doom-emacs-unstraightened; };  #Add in home
	  }
        ]; 
     };
  };
}
