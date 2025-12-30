{ ... }: {
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set -g fish_greeting ""
    
      if not set -q TMUX && test "$TERM_PROGRAM" != "vscode"
        if command -v fastfetch >/dev/null 2>&1
          fastfetch
          echo
        end
      end
    
      if command -v starship >/dev/null 2>&1
        starship init fish | source
      end
    '';
  };
}
