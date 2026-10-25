function fish_greeting
  fastfetch
end

# zoxide
if status is-interactive
    command -q zoxide; and zoxide init --cmd=cd fish | source
end

# fzf
command -q fzf; and fzf --fish | source

# starship
command -q starship; and starship init fish | source
