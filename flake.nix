{	
  description = "WaifuRoom NixBTW";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
   
  outputs = { self, nixpkgs, home-manager, ... }:
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
	  }
        ]; 
     };
  };
}
