{ self, inputs, ... }: {
  flake.nixosModules.sops =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      cfg = config.local.sops;
    in
    {
      imports = [ inputs.sops-nix.nixosModules.sops ];

      options.local.sops = {
        enable = lib.mkEnableOption "Enable sops secret decryption";
      };
      config = lib.mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
          sops
          age
        ];

        sops = {
          defaultSopsFile = ../../secrets/common.yaml;
          age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

          secrets = {
            hello = { };
          };
        };

        environment.variables.SOPS_AGE_KEY_CMD = "${pkgs.ssh-to-age}/bin/ssh-to-age -private-key -i /etc/ssh/ssh_host_ed25519_key";
      };

    };

}
