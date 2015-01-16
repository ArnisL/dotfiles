#export TERM="screen-256color"
#TERM="screen-256color"
#TERM="xterm"

ZSH=$HOME/.oh-my-zsh
ZSH_THEME="af-magic"

source ~/scripts/antigen.zsh
antigen use oh-my-zsh

#antigen bundle git
#antigen bundle pip
#antigen bundle lein
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions

antigen bundle zsh-users/zsh-history-substring-search
# bind UP and DOWN arrow keys
for keycode in '[' '0'; do
  bindkey "^[${keycode}A" history-substring-search-up
  bindkey "^[${keycode}B" history-substring-search-down
done
unset keycode
# bind P and N for EMACS mode
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

#antigen theme fox
antigen apply

## Set some ZSH auto complete options
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*:killall:*' command 'ps -u $USER -o cmd'

## History stuffs
HISTFILE=~/.zsh-histfile
HISTSIZE=5000
SAVEHIST=5000
setopt incappendhistory
setopt sharehistory
setopt extendedhistory

plugins=(git ruby virtualenv)

source ~/.oh-my-zsh/oh-my-zsh.sh

# Customize to your needs...
export PATH=/home/lapsa/bin/:/home/lapsa/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/home/lapsa/.rvm/bin

alias paux='ps aux | grep '
alias k9='kill -9 '
alias branch='git branch'
alias stable='git checkout stable'
alias testing='git checkout testing'
alias master='git checkout master'
alias edge='git checkout edge'
alias zshconfig='vim ~/.zshrc'
alias sshconfig='vim ~/.ssh/config'
alias bashconfig='vim ~/.bashrc'
alias tmuxconfig='vim ~/.tmux.conf'
alias tmuxreload='tmux source-file ~/.tmux.conf'
alias pull='git pull --rebase'
alias push='git push origin'
alias status='git status --short'
alias add='git add .'
alias commit='git commit'
alias log='git log --pretty=oneline --abbrev-commit'
alias eunethack='telnet eu.un.nethack.nu'
alias untar='tar -xvzf'
# alias irssi='TERM=screen-256color irssi'
# alias tmux='TERM=xterm-256color tmux'
alias log_work='git log --pretty=oneline --format="%ad %h %s" --author="Arnis Lapsa" --date=short'
alias nyanspec='bundle exec rspec --format NyanCatFormatter'
alias diff='git diff'

# ls stuff>>>
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
# <<<ls stuff


export LD_LIBRARY_PATH=/u01/app/oracle/11.2.0/xe/lib/
export ORACLE_BASE=/u01/app/oracle/product/11.2.0/xe/
export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe/
export ORACLE_SID=XE
export TNS_ADMIN=/home/lapsa/
export NODE_PATH=/usr/local/lib/node

export BROWSER='/usr/bin/chromium-browser'

alias rake_databases='rake db:drop && rake db:create && rake db:migrate && rake db:seed && rake lapsa:seed && rake db:test:clone && rake users:import'

# rvm bullshitfix
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  


VLESS=$(find /usr/share/vim -name 'less.sh')
if [ ! -z $VLESS ]; then
  alias less=$VLESS
fi

alias tmux='TERM=xterm-256color tmux'

alias activitydate_staging_log="ssh -p 22209 rails@92.240.69.38 -t 'tail -f staging/current/log/staging.log;bash -l'"
alias activitydate_production_log="ssh rails@151.236.218.190 -t 'tail -f production/current/log/production.log;bash -l'"

alias activitydate_staging="ssh -p 22209 rails@92.240.69.38 -t 'cd staging/current;bash -l'"
alias activitydate_production="ssh rails@151.236.218.190 -t 'cd production/current;bash -l'"
alias steal_activitydate_production_db="rm ~/db.sql ; cd ~/code/activitydate/ && rake db:drop && rake db:create && ssh activitydate -t 'cd production/current && pg_dump -O activitydate_production > ~/db.sql && exit;bash -l' && scp ssh activitydate:~/db.sql ~/ ; ssh activitydate -t 'rm ~/db.sql ; exit;bash -l' ; echo 'Password: postgres' ; echo 'Execute manually:' ; echo 'psql activitydate_development < /home/lapsa/db.sql && exit' ; su postgres"

export EDITOR='vim'
alias nyan='telnet -t vtnt nyancat.dakko.us'
#alias rspec_dots='alias rspec="rspec -f p"'
#alias rspec_nodots='alias rspec="rspec"'
#alias rspec='spring rspec'
#alias spec='spring rspec'
alias spec='rspec'

gitCheckout() {
    git checkout $1 && bundle
}
alias checkout=gitCheckout
