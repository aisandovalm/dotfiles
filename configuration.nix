{ user, ... }:

{
  # Determinate already manages the Nix daemon, so nix-darwin shouldn't.
  nix.enable = false;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin"; # use x86_64-darwin for Intel CPU

  system.primaryUser = user;
  users.users.${user} = {
    home = "/Users/${user}";
  };
  system.stateVersion = 6;
  system.defaults = {
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      KeyRepeat = 2;          # fast key repeat
      InitialKeyRepeat = 15;  # short delay before repeat
      _HIHideMenuBar = true;  # auto-hide the menu bar
      AppleShowAllExtensions = true;
    };
    dock.autohide = true;
    finder.FXPreferredViewStyle = "Nlsv";  # list view by default
    finder.CreateDesktop = false;          # clean desktop
    trackpad.Clicking = true;              # tap to click
  };
  nix-homebrew = {
    enable = true;
    inherit user;
    autoMigrate = true;
  };
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";  # remove anything not listed here
    onActivation.autoUpdate = true;
    onActivation.extraFlags = [ "--force" ];
    brews = [
      "herdr"
      "jq"
    ];
    casks = [
      # already declared
      "wezterm"
      "claude-code"

      # added from /Applications audit (2026-07-08) - see dotfiles README/commit
      # for what was deliberately left out (MDM-managed apps, free App Store
      # apps, and a few with no verified Homebrew cask).
      "1password"
      "adobe-acrobat-reader"
      "anaconda"
      "android-file-transfer"
      "claude"
      "codex"
      "firefox"
      "google-chrome"
      "grammarly-desktop"
      "iina"
      "maccy"
      "netron"
      "obsidian"
      "slack"
      "tailscale-app"
      "visual-studio-code"
    ];
  };
}
