{	
  description = "WaifuRoom NixBTW";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lazyvim-nix.url = "github:pfassina/lazyvim-nix";  # <-- ADD THIS
  };
   
  outputs = { self, nixpkgs, home-manager, lazyvim-nix, ... }:
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
	   home-manager.extraSpecialArgs = { inherit lazyvim-nix; };  #Add in home
	  }
        ]; 
     };
  };
}
