{ config, pkgs, user, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.dotfiles";

  # Personal Claude Code skills actually live in the protex-intelligence/brain
  # repo, not in ~/.claude. These entries just recreate the symlinks that used
  # to be set up by hand, so a fresh machine gets them automatically as long
  # as that repo is cloned at the path below. If it isn't cloned yet, these
  # will be dangling symlinks until you clone it.
  brainDir = "${config.home.homeDirectory}/repositories/protex-intelligence/brain";

  brainSkills = [
    "ask-questions-if-underspecified"
    "deploy-to-dev-device"
    "device-check"
    "fleet-inventory-sync"
    "git-commit-per-file"
    "greengrass-release"
    "maintenance-window"
    "pdt-cycle-planner"
    "protex-brand-docs"
    "protex-design-system"
    "protex-pr-reviewer"
    "rollout-check"
    "rollout-status-sync"
  ];
  brainPlugins = [ "proharness" ];

  brainSkillLinks = builtins.listToAttrs (map (n: {
    name = ".claude/skills/${n}";
    value.source = config.lib.file.mkOutOfStoreSymlink "${brainDir}/skills/${n}";
  }) brainSkills);

  brainPluginLinks = builtins.listToAttrs (map (n: {
    name = ".claude/skills/${n}";
    value.source = config.lib.file.mkOutOfStoreSymlink "${brainDir}/plugins/${n}";
  }) brainPlugins);
in

{
  home.username = user;
  home.homeDirectory = "/Users/${user}";
  home.stateVersion = "24.11";
  home.packages = with pkgs; [
    # cli i use constantly
    ripgrep   # fast search
    fd        # fast find
    fzf       # fuzzy finder
    jq        # json on the command line
    lazygit
    neovim
    # the font everything renders in
    nerd-fonts.hack
  ];
  fonts.fontconfig.enable = true;
  home.sessionVariables.EDITOR = "nvim";

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;      # ghost text from history
    syntaxHighlighting.enable = true;  # commands turn green when valid
    initContent = ''
      bindkey '^f' autosuggest-accept
    '';
    shellAliases = {
      ".." = "cd ..";
      add = "git add .";
      push = "git push";
      pull = "git pull";
      m = "git switch main";
      cc = "claude --dangerously-skip-permissions";
      co = "codex --full-auto";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = "$directory$git_branch$git_status$cmd_duration$line_break$character";
      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
      };
      cmd_duration.format = "[$duration]($style) ";
    };
  };

  # Edit-in-place: the real file stays in my repo, ~/.config just points at it.
  home.file = {
    ".config/wezterm".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/wezterm";
    ".config/nvim".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/nvim";
    ".config/herdr".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/herdr";
    ".claude/settings.json".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.claude/settings.json";

    ".claude/CLAUDE.md".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/AGENTS.md";
    ".codex/AGENTS.md".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/AGENTS.md";
    ".config/opencode/AGENTS.md".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/AGENTS.md";
  } // brainSkillLinks // brainPluginLinks;
}
