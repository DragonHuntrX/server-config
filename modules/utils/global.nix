{ self, inputs, ... }: {

  flake.nixosModules.global = { pkgs, ... }: {
    imports = with self.nixosModules; [
      tailscale
      sops
    ];

    environment.systemPackages = with pkgs; [
      helix
      git
      curl
      nixd
      nil
    ];
    environment.variables.EDITOR = "hx";
  };

}
