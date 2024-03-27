# alias emacs to use emacs client if ran through terminal
alias emacs="emacsclient -c -a 'emacs'"

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls --color=auto'

# grep aliases
alias grep='grep --color=auto'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# docker aliases
alias docker='podman'
alias docker-compose='podman-compose'

# git aliases
alias gitdiffcs="git diff --cached --stat"
alias gitdiffcw="git diff --cached --color-words"