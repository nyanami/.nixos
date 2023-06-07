{ pkgs, ... }: {
  services.xserver = {
    enable = true;

    excludePackages = [
      pkgs.xterm
    ];

    desktopManager.plasma5.enable = true;
    displayManager.sddm.enable = true;
  };

  environment.plasma5.excludePackages = [
    pkgs.libsForQt5.elisa
  ];

  environment.systemPackages = with pkgs; [
    plasma-pa
  ];

  xdg.portal.enable = true;
}
