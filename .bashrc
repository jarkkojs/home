# Exit, if non-interactive shell.
[[ $- != *i* ]] && return

export SSH_AUTH_SOCK=`gpgconf --list-dirs agent-ssh-socket`
export COLORTERM=24bit
export HISTFILESIZE=10000 # persistent
export HISTSIZE=2500 # transient
export TERM=xterm-256color
export BAT_THEME=Dracula

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Fedora
[ -e /usr/libexec/mc/mc-wrapper.sh ] && alias mc='. /usr/libexec/mc/mc-wrapper.sh'
# Ubuntu
[ -e /usr/lib/mc/mc-wrapper.sh ] && alias mc='. /usr/lib/mc/mc-wrapper.sh'

# $1 = remote
# $2 = branch
function git-fetch-reset {
  git fetch "$1" && git reset --hard "$1/$2"
}

function git-fetch-tag {
  git fetch --no-tags "$1" "refs/tags/$2:refs/tags/$2"
}

# $1 = commit ID
function git-fixes {
  git --no-pager log --format='Fixes: %h ("%s")' --abbrev=12 -1 $1;
}

# $1 = repository
function git-init-bare {
  git init --bare -b main $1
}

function git-tip {
  git --no-pager log --oneline -1;
}

# Ubuntu
if [ ! -z "`which batcat`" ]; then
  alias cat='batcat -p --pager never'
  alias less='batcat -p'
elif [ ! -z "`which bat`" ]; then
  alias cat='bat -p --pager never'
  alias less='bat -p'
fi

if [ ! -z "`which exa`" ]; then
  alias ls='exa'
fi

[ -z "$(which starship)" ] || eval "$(starship init bash)"

if [ -f "$HOME/.local.bashrc" ] ; then
  source "$HOME/.local.bashrc"
fi
