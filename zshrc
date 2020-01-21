export ZSH=$HOME/.oh-my-zsh
export PATH=$HOME/tools:$PATH

######################################################################
# Use antigen to setup oyh-my-zsh.
######################################################################

source $HOME/tools/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"

# Uncomment the following line to change how often to auto-update (in days).
UPDATE_ZSH_DAYS=30

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE=true

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle z
antigen bundle colorize
antigen bundle docker
antigen bundle git
antigen bundle history
antigen bundle httpie
antigen bundle mvn
antigen bundle lein
antigen bundle aws
antigen bundle djui/alias-tips
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle nvm

# theme
antigen theme https://github.com/caiogondim/bullet-train-oh-my-zsh-theme bullet-train

BULLETTRAIN_PROMPT_ORDER=(
  time
  dir
  git
)

BULLETTRAIN_GIT_BG=blue
BULLETTRAIN_GIT_FG=white
BULLETTRAIN_TIME_BG=green
BULLETTRAIN_TIME_FG=white
BULLETTRAIN_CONTEXT_BG=blue
BULLETTRAIN_CONTEXT_FG=white
BULLETTRAIN_DIR_CONTEXT_SHOW=true

# Tell antigen that you're done.
antigen apply

# Make page-up/-down search for entries having the same prefix as currently entered.
bindkey "^[[5~" history-beginning-search-backward
bindkey "^[[6~" history-beginning-search-forward
bindkey \^U backward-kill-line

# stop complaining about unmatched wildcards
unsetopt nomatch
setopt extendedglob

######################################################################
# Environment variables used by various tools.
######################################################################

export GIT_MERGE_AUTOEDIT=no    # do not open editor when committing a merge in git
export EDITOR=vim
export WORDCHARS='*?_-[]~=&!$%^(){}<>'

######################################################################
# Aliases and shortcuts for various development tools.
######################################################################

alias g='git status'
alias gg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias ac='git commit -a --amend'
alias git-restart='git checkout master && git pull && git remote prune origin && git branch --merged master | grep -v "^[ *]*master$" | xargs git branch -d'
alias gpo='gp -u origin `git rev-parse --abbrev-ref HEAD`'

alias head='head -n 20'

alias mvn='mvn-color'
alias mp='mvn clean package'
alias mi='mvn install'
alias md='mvn deploy'

######################################################################
# Setting up tools.
######################################################################

case `uname` in
  Darwin)
    source /Users/bhachmann/Library/Preferences/org.dystroy.broot/launcher/bash/br
  ;;
  Linux)
    source /home/hman/.config/broot/launcher/bash/br
  ;;
esac
