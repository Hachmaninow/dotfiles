
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# stop complaining about unmatched wildcards
unsetopt nomatch

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"
DISABLE_AUTO_UPDATE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(git git-flow-avh mvn osx redis-cli vagrant autojump bundler)

source $ZSH/oh-my-zsh.sh

# Make page-up/-down search for entries having the same prefix as currently entered.
bindkey "^[[5~" history-beginning-search-backward
bindkey "^[[6~" history-beginning-search-forward
bindkey \^U backward-kill-line

export EDITOR=vim

if [ "$HOST" = "macbook" ]; then
  export PATH="$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bini:$HOME/.rvm/bin"

  export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
  export JRUBY_OPTS="-J-Xmx4096m -J-XX:MaxMetaspaceSize=2048m -J-Dfile.encoding=UTF-8 -J-XX:+TieredCompilation -J-XX:TieredStopAtLevel=1 -X-C -Xcompile.mode=OFF"
  # export JRUBY_OPTS="-J-Xmx4096m -J-XX:MaxPermSize=2048m -J-Dfile.encoding=UTF-8 -J-XX:+TieredCompilation -J-XX:TieredStopAtLevel=1 -X-C"
  source /usr/local/Cellar/autojump/21.6.9/etc/autojump.zsh
  [[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

  # metrigo specific aliases
  alias release='mvn deploy; rake build; gem inabox'
  alias update='bundle exec update_metrigo_deps.rb'
  alias check='mvn package; rake'
fi

export WORDCHARS='*?_-[]~=&!$%^(){}<>' 


# standard aliases
alias g='git status'
alias l='git log-nice'

local ret_status="%(?:%{$fg_bold[green]%}🍀 :%{$fg_bold[red]%}🍀 %s)"
PROMPT='${ret_status} %{$fg[white]%}%n %{$fg_bold[blue]%}%m %{$fg_bold[green]%}%p %{$fg[cyan]%}%~ %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

