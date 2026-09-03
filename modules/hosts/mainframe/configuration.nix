{ self, inputs, ... }:
{
  flake.nixosModules.mainframeConfig =
    {
      config,
      lib,
      pkgs,
      ...
    }:

    {
      imports = with self.nixosModules; [
        mainframeHConfig
        tailscale
      ];

      # Use the systemd-boot EFI boot loader.
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      networking.hostName = "mainframe"; # Define your hostname.

      # Configure network connections interactively with nmcli or nmtui.
      networking.networkmanager.enable = true;
      networking.firewall.allowedTCPPorts = [ 22 ];

      users.users.ghost = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIJR6zyuKXiR0TxiC6QXXjz6mY5KTLoJdpAMQRXqVucB"
        ];
      };

      environment.systemPackages = with pkgs; [
        helix
        git
        curl
        nil
        nixd
      ];

      services.openssh = {
        enable = true;
        settings = {
          PermitRootLogin = "no";
          PasswordAuthentication = false;
        };
      };

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      # This option defines the first version of NixOS you have installed on this particular machine,
      # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
      #
      # Most users should NEVER change this value after the initial install, for any reason,
      # even if you've upgraded your system to a new NixOS release.
      #
      # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
      # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
      # to actually do that.
      #
      # This value being lower than the current NixOS release does NOT mean your system is
      # out of date, out of support, or vulnerable.
      #
      # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
      # and migrated your data accordingly.
      #
      # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
      system.stateVersion = "26.05"; # Did you read the comment?

    };
}
