{ self, inputs, ... }: {
  flake.nixosConfigurations.installer = inputs.nixpkgs.lib.nixosSystem {
    modules = [ self.nixosModules.installerConfig ];
  };
}
