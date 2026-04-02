{
    description = "Walrus's NixOS";
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-25.05";
        home-manager = {
            url = "github:nix-community/home-manager/release-25.04";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, ... }: {
        nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
            system = "amd64-linux";
            modules = [
                ./configuration.nix
                    home-manager.nixosModules.home-manager
                    {
                        home-manager = {
                            useGlobalPkgs = true;
                            useUserPackages = true;
                            users.walrus = import ./home.nix;
                            backupFileExtension = "backup";
                        };
                    }
            ];
        };
    };

}
