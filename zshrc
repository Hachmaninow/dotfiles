# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# stop complaining about unmatched wildcards
unsetopt nomatch

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(git git-flow-avh mvn osx redis-cli vagrant autojump bundler)

source $ZSH/oh-my-zsh.sh

bindkey "^[[5~" history-beginning-search-backward
bindkey "^[[6~" history-beginning-search-forward
bindkey \^U backward-kill-line

export PATH="$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bini:$HOME/.rvm/bin"
export EDITOR=vim
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

export WORDCHARS='*?_-[]~=&!$%^(){}<>' 

export JRUBY_OPTS="-J-Xmx4096m -J-XX:MaxMetaspaceSize=2048m -J-Dfile.encoding=UTF-8 -J-XX:+TieredCompilation -J-XX:TieredStopAtLevel=1 -X-C -Xcompile.mode=OFF"
# export JRUBY_OPTS="-J-Xmx4096m -J-XX:MaxPermSize=2048m -J-Dfile.encoding=UTF-8 -J-XX:+TieredCompilation -J-XX:TieredStopAtLevel=1 -X-C"

source /usr/local/Cellar/autojump/21.6.9/etc/autojump.zsh
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh


# standard aliases
alias g='git status'
alias l='git l'

# metrigo specific aliases
alias update='bundle exec update_metrigo_deps.rb'
alias check='mvn package; rake'
alias release='mvn deploy; rake build; gem inabox'


# get pid of locally running bidder
alias bidderps='jps -l | grep jruby | cut -d " " -f 1'

# start jmxterm (tool for command line access to jmxserver)
alias jmxterm='java -jar ~/Tools/jmxterm/jmxterm-1.0-SNAPSHOT-uber.jar'

alias update_deps='bundle exec update_metrigo_deps.rb'

local ret_status="%(?:%{$fg_bold[green]%}🍀 :%{$fg_bold[red]%}🍀 %s)"
PROMPT='${ret_status} %{$fg[white]%}%! %{$fg_bold[blue]%}%m %{$fg_bold[green]%}%p %{$fg[cyan]%}%~ %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

project_status() { 
  echo "Status $1"
}

my_status() {
  for x ('bidder', 'rtb_engine', 'memento'); do
     project_status($x); 
  done
}


