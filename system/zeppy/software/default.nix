{ pkgs, ... }: {
  imports = [
    ./desktop/plasma5.nix
  ];

  #services.tlp.enable = true;
  programs.steam.enable = true; # steam needs to by installed system-wide :(
  programs.fish.enable = true;
  programs.dconf.enable = true;

  services.tailscale.enable = true;
  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    gitMinimal
    neovim
    tmux

    nvtop-amd
    htop

    rsync
    curl

    python3Minimal
    pipenv

    distrobox
    qemu
    virt-manager

    wl-clipboard
  ];

  nixpkgs.overlays = [
    (final: prev: {
      steam = prev.steam.override ({ extraPkgs ? pkgs': [], ... }: {
        extraPkgs = pkgs': (extraPkgs pkgs') ++ (with pkgs'; [
          openssl
	]);
      });
    })
  ];

  virtualisation = {
    #waydroid.enable = true;
    #lxd.enable = true;
    podman = {
      enable = true;
      dockerCompat = false;
      
      defaultNetwork.settings = {
        dns_enabled = true;
      };
    };
    libvirtd = {
      enable = true;
      #qemu.verbatimConfig = ''
      #  user = "skk"
      #'';
    };
  };

  environment.etc = {
    "libvirt/qemu.conf" = {
      text = ''
        user = "skk"
      '';

      mode = "0644";
    };
  };

  environment.variables = {
    EDITOR = "nvim";
  };

  programs.nano.syntaxHighlight = false;
  environment.defaultPackages = [];
}
