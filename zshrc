
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# stop complaining about unmatched wildcards
unsetopt nomatch

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="bureau"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(git git-flow-avh mvn redis-cli vagrant autojump bundler)

source $ZSH/oh-my-zsh.sh

# Make page-up/-down search for entries having the same prefix as currently entered.
bindkey "^[[5~" history-beginning-search-backward
bindkey "^[[6~" history-beginning-search-forward
bindkey \^U backward-kill-line

export PATH=/home/hman/tools/:$PATH
export EDITOR=vim
export JRUBY_OPTS="-J-Xmx4096m -J-XX:MaxMetaspaceSize=2048m -J-Dfile.encoding=UTF-8 -J-XX:+TieredCompilation -J-XX:TieredStopAtLevel=1 -X-C -Xcompile.mode=OFF"
export WORDCHARS='*?_-[]~=&!$%^(){}<>' 
export GIT_MERGE_AUTOEDIT=no    # do not open editor when committing a merge in git

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

######################################################################
# Customizing the prompt.
######################################################################

#local ret_status="%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%}%s)"
#PROMPT='${ret_status} %{$fg[cyan]%}%n %{$fg_bold[blue]%}%m %{$fg_bold[green]%}%p %{$fg[cyan]%}%~ %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

######################################################################
# The following code deals with  providing abbreviations in zsh.
# Type in the abbreviation and type space 2x fast!
######################################################################

setopt extendedglob

typeset -A abbrevs
abbrevs=(
	"depl" "bundle exec cap"
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

