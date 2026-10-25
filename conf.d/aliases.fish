# editor
alias vim="nvim"

# git
alias ga='git add'
alias gc='git commit -v'
alias gco='git checkout'
alias gd='git diff'
alias gl='git pull'
alias gp='git push'
alias gst='git status'
alias gb='git branch'

# ls
alias ls='eza --icons --group-directories-first --no-user'
alias ll='eza -l --icons --group-directories-first --no-user'
alias la='eza -la --icons --group-directories-first --no-user'
# tree listing
alias lt='eza -aT --color=always --group-directories-first --icons=always --no-user'
# show only dotfiles
alias l.="eza -a | grep -e '^\.'"                                          

# cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# grep
alias grep='grep --color=auto'

# cat -> bat
alias cat='bat --paging=never --style=plain'
