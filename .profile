if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
  PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.cargo/bin" ] ; then
  PATH="$HOME/.cargo/bin:$PATH"
fi

if [ -d "$HOME/.local/share/yabridge" ] ; then
 PATH="$PATH:$HOME/.local/share/yabridge"
fi

if [ -d "$HOME/.local/opt/wine-tkg/bin" ] ; then
  PATH="$HOME/.local/opt/wine-tkg/bin:$PATH"
fi

export WINEFSYNC=1

if [ -d "/opt/local/bin" ]; then
  PATH="/opt/local/bin:/opt/local/sbin:$PATH"
  MANPATH="/opt/local/share/man:$MANPATH"
fi

if [ -d "/opt/homebrew/bin" ]; then
  PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
  MANPATH="/opt/homebrew/share/man:$MANPATH"
fi

export MANPATH
export PATH

# systemctl --user import-environment PATH

if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi

[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

if [ -x "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
