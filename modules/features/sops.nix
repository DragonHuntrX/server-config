{ self, inputs, ... }: {
  flake.nixosModules.sops =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      imports = [ inputs.sops-nix.nixosModules.sops ];
      environment.systemPackages = with pkgs; [
        sops
        age
      ];

      sops.defaultSopsFile = ./secrets/secrets.yaml;
      sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    };

}
