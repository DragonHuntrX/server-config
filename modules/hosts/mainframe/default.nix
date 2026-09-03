{ self, inputs, ... }: {
  flake.nixosConfigurations.mainframe = inputs.nixpkgs.lib.nixosSystem {
    modules = [ self.nixosModules.mainframeConfig ];
  };
}

