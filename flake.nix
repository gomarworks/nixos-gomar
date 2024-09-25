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
      # ATLAS - Work Desktop configuration
      atlas = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/atlas/configuration.nix  # Work desktop's configuration
          inputs.home-manager.nixosModules.default
          inputs.stylix.nixosModules.stylix
        ];
      };

      # EOS -Home Desktop configuration
      eos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/eos/configuration.nix  # Home desktop VM's configuration
          inputs.home-manager.nixosModules.default
          inputs.stylix.nixosModules.stylix
        ];
      };

      # Freedman - Laptop configuration
      freedman = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
       	specialArgs = { inherit inputs; };
        modules = [
          ./hosts/freedman/configuration.nix  # Laptop's configuration (if applicable)
          inputs.home-manager.nixosModules.default
          inputs.stylix.nixosModules.stylix
        ];
      };

      # NYX - HTPC configuration
      nyx = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
       	specialArgs = { inherit inputs; };
        modules = [
          ./hosts/nyx/configuration.nix  # HTPC's configuration (if applicable)
          inputs.home-manager.nixosModules.default
          inputs.stylix.nixosModules.stylix
        ];
      };

      # Raspberry Pi configuration
      minimises = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/minimises/configuration.nix  # Raspberry Pi's configuration
          inputs.home-manager.nixosModules.default
          inputs.disko.nixosModules.disko
        ];
      };
    };
  };
}
