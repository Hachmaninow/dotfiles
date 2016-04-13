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
antigen bundle git
antigen bundle git-flow-avh
antigen bundle mvn
antigen bundle redis-cli
antigen bundle autojump
antigen bundle lein
antigen bundle colorize
antigen bundle history
antigen bundle supervisor
antigen bundle tmux
antigen bundle urltools
antigen bundle jira
antigen bundle docker
antigen bundle jruby
antigen bundle bundler
antigen bundle rake
antigen bundle gem
antigen bundle debian
antigen bundle sudo
antigen bundle djui/alias-tips

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme bureau

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

function cm {
  git diff CHANGES.md | grep -E '^\+\*' | sed 's/^...//' | paste -sd';'
}

alias fci='git commit -am "$(cm)"'
alias ac='git commit -a --amend'
alias bv='git commit -am "version bump"'

alias mp='mvn clean package'
alias mi='mvn install'
alias md='mvn deploy'

alias lj='bundle exec lockjar lock'

function current-version {
  grep -E '<version>.*</version>' pom.xml | head -n 1 | grep -E -o '[0-9]+\.[0-9]+\.[0-9]+' | awk -F "." '{print $1 "." $2 "." $3}'
}
function next-patch-version {
  grep -E '<version>.*</version>' pom.xml | head -n 1 | grep -E -o '[0-9]+\.[0-9]+\.[0-9]+' | awk -F "." '{print $1 "." $2 "." $3+1}'
}
function next-minor-version { 
  grep -E '<version>.*</version>' pom.xml | head -n 1 | grep -E -o '[0-9]+\.[0-9]+\.[0-9]+' | awk -F "." '{print $1 "." $2+1 "." $3}'
}

alias sp='git flow release start -F $(next-patch-version) && sed -i "1s/.*/## edge\n\n## $(next-patch-version)/" CHANGES.md && mvn versions:set -DnewVersion=$(next-patch-version) -DgenerateBackupPoms=false && git commit -am "version bump"'
alias sr='git flow release start -F $(next-minor-version) && sed -i "1s/.*/## edge\n\n## $(next-minor-version)/" CHANGES.md && mvn versions:set -DnewVersion=$(next-minor-version) -DgenerateBackupPoms=false && git commit -am "version bump"'
alias fr='git flow release finish -m "release: " -p $(current-version)'

alias cinnamon-restart="sudo killall -HUP cinnamon"





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


######################################################################
# Initialize rvm for ruby development.
######################################################################

source ~/.rvm/scripts/rvm


export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
