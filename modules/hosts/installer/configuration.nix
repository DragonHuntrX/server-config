{ self, inputs, ... }:
{
  flake.nixosModules.installerConfig =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      imports = [ "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix" ];

      nixpkgs.hostPlatform = "x86_64-linux";

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      services.openssh.enable = true;

      networking.networkmanager.enable = true;

      environment.systemPackages = with pkgs; [
        parted
        dosfstools
        btrfs-progs
        util-linux
        coreutils
        curl
        git
        helix
      ];
      users.users.root.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKXFLZqIlvH0zocy86iT47YVRli4ntXYAkJ5qPBrgfgX"
      ];

      networking.firewall.allowedTCPPorts = [ 22 ];
      system.nixosVersion = "26.05";
    };
}
