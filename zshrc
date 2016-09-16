# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

source ~/tools/antigen/antigen.zsh

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
antigen bundle aws
antigen bundle djui/alias-tips
antigen bundle autojump
antigen bundle bundler
antigen bundle capistrano
antigen bundle colorize
antigen bundle debian
antigen bundle docker
antigen bundle gem
antigen bundle git
antigen bundle git-flow-avh
antigen bundle history
antigen bundle httpie
antigen bundle jruby
antigen bundle lein
antigen bundle mvn
antigen bundle rake
antigen bundle redis-cli
antigen bundle sudo
antigen bundle supervisor
antigen bundle tmux
antigen bundle urltools
antigen bundle virtualenvwrapper

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# theme
antigen theme https://github.com/caiogondim/bullet-train-oh-my-zsh-theme bullet-train

BULLETTRAIN_PROMPT_ORDER=(
  time
  context
  dir
  git
)

BULLETTRAIN_GIT_BG=black
BULLETTRAIN_GIT_FG=white
BULLETTRAIN_TIME_BG=black
BULLETTRAIN_TIME_FG=white
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


export PATH=$HOME/tools:$PATH
#export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/jvm/java-8-oracle/bin:/usr/lib/jvm/java-8-oracle/db/bin:/usr/lib/jvm/java-8-oracle/jre/bin"

export EDITOR=vim

export WORDCHARS='*?_-[]~=&!$%^(){}<>'



######################################################################
# Environment variables used by various tools.
######################################################################

export GIT_MERGE_AUTOEDIT=no    # do not open editor when committing a merge in git

export JRUBY_OPTS="-J-Xmx4096m -J-XX:MaxMetaspaceSize=2048m -J-Dfile.encoding=UTF-8 -J-XX:+TieredCompilation -J-XX:TieredStopAtLevel=1 -X-C -Xcompile.mode=OFF"


######################################################################
# Aliases and shortcuts for various development tools.
######################################################################

alias g='git status'
alias gg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

function cm {
  git diff CHANGES.md | grep -E '^\+\*' | sed 's/^...//' | paste -sd';'
}

alias fci='git commit -am "$(cm)"'
alias ac='git commit -a --amend'
alias bv='git commit -am "version bump"'

alias mp='mvn clean package'
alias lj='bundle exec lockjar lock'

function current-version {
  grep -E '<version>.*</version>' pom.xml | head -n 1 | grep -E -o '[0-9]+\.[0-9]+\.[0-9]+' | awk -F "." '{print $1 "." $2 "." $3}'
}
function next-patch-version {
  grep -E '<version>.*</version>' pom.xml | head -n 1 | grep -E -o '[0-9]+\.[0-9]+\.[0-9]+' | awk -F "." '{print $1 "." $2 "." $3+1}'
}
function next-minor-version { 
  grep -E '<version>.*</version>' pom.xml | head -n 1 | grep -E -o '[0-9]+\.[0-9]+\.[0-9]+' | awk -F "." '{print $1 "." $2+1 ".0" }'
}

alias sp='git flow release start -F $(next-patch-version) && sed -i "1s/.*/## edge\n\n## $(next-patch-version)/" CHANGES.md && mvn versions:set -DnewVersion=$(next-patch-version) -DgenerateBackupPoms=false && git commit -am "version bump"'
alias sr='git flow release start -F $(next-minor-version) && sed -i "1s/.*/## edge\n\n## $(next-minor-version)/" CHANGES.md && mvn versions:set -DnewVersion=$(next-minor-version) -DgenerateBackupPoms=false && git commit -am "version bump"'
alias fr='git flow release finish -m "release: " -p $(current-version)'


######################################################################
# The following code deals with  providing abbreviations in zsh.
# Type in the abbreviation and type space 2x fast!
######################################################################

setopt extendedglob

typeset -A abbrevs
abbrevs=(
  "depl" "bundle exec cap"
  "ddepl" "BRANCH=develop bundle exec cap staging deploy restart_"
  "rt" "bundle exec ruby -I test"
  "fs" "git flow feature start"
  "ff" "git flow feature finish"
  "rs" "git flow release start"
  "rf" "git flow release finish"
)

# create aliases for the abbrevs too
for abbr in ${(k)abbrevs}; do
        alias -g $abbr="${abbrevs[$abbr]}"
done

globalias() {
        local MATCH
        LBUFFER=${LBUFFER%%(#m)[_a-zA-Z0-9]#}
        LBUFFER+=${abbrevs[$MATCH]:-$MATCH}
        zle self-insert
}

zle -N globalias

bindkey "  " globalias
bindkey " " magic-space

if [[ -f ~/.rvm/scripts/rvm ]];
then
  source ~/.rvm/scripts/rvm
  export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
fi
