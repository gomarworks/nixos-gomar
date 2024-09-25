{
  description = "gomars multi machine magic flake";

  inputs = {
    # Pulling the Nixpkgs input from the stable NixOS release 24.05
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Disko for disk layout
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secrets management
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home Manager input, following the same Nixpkgs version
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixVim input, also following the same Nixpkgs version
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Stylix input for additional configurations
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      # Work Desktop configuration
      atlas = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/atlas/configuration.nix  # Work desktop's configuration
          inputs.home-manager.nixosModules.default
          inputs.stylix.nixosModules.stylix
        ];
      };

      # Home Desktop VM configuration
      homeDesktopVM = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/homeDesktopVM/configuration.nix  # Home desktop VM's configuration
          inputs.home-manager.nixosModules.default
          inputs.stylix.nixosModules.stylix
        ];
      };

      # Laptop configuration
      workLaptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
       	specialArgs = { inherit inputs; };
        modules = [
          ./hosts/workLaptop/configuration.nix  # Laptop's configuration (if applicable)
          inputs.home-manager.nixosModules.default
          inputs.stylix.nixosModules.stylix
        ];
      };

      # HTPC configuration
      HTPC = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
       	specialArgs = { inherit inputs; };
        modules = [
          ./hosts/HTPC/configuration.nix  # HTPC's configuration (if applicable)
          inputs.home-manager.nixosModules.default
          inputs.stylix.nixosModules.stylix
        ];
      };

      # Raspberry Pi configuration
      raspberryPi = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/workPi/configuration.nix  # Raspberry Pi's configuration
          inputs.home-manager.nixosModules.default
          inputs.disko.nixosModules.disko
        ];
      };
    };
  };
}
