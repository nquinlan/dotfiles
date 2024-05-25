# User configuration
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Add Git Completion
for file in /usr/local/etc/bash_completion.d/{git-completion.bash,git-prompt.sh}; do
	ls $file &> /dev/null && source $file 
done
unset file

GIT_PS1_SHOWUNTRACKEDFILE=1
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWDIRTYSTATE=1

# Set PS1 (Initial) Text
# PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
PROMPT_COMMAND='__git_ps1 "[\u@\h:\w" ]"\\\$ "'

# Load the shell dotfiles, and then some:
# * ~/.dotfiles/path can be used to extend `$PATH`.
# * ~/.dotfiles/extra can be used for other settings you don’t want to commit.
for file in ~/.dotfiles/{path,exports,aliases,extra,computer}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

eval "$(pyenv init -)"

# Add GOPATH
export PATH="$PATH:/usr/local/go/bin"
export GOPATH="$HOME/dev/go"


# JINA_CLI_BEGIN

## autocomplete
_jina() {
  COMPREPLY=()
  local word="${COMP_WORDS[COMP_CWORD]}"

  if [ "$COMP_CWORD" -eq 1 ]; then
    COMPREPLY=( $(compgen -W "$(jina commands)" -- "$word") )
  else
    local words=("${COMP_WORDS[@]}")
    unset words[0]
    unset words[$COMP_CWORD]
    local completions=$(jina completions "${words[@]}")
    COMPREPLY=( $(compgen -W "$completions" -- "$word") )
  fi
}

complete -F _jina jina

# session-wise fix
ulimit -n 4096
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# JINA_CLI_END

export GAMCFGDIR="/Users/nick/dev/gam/GAMConfig"
alias gam="/Users/nick/dev/gam/bin/gam/gam"

alias gam="/Users/nick/dev/gam/bin/gamadv-xtd3/gam"
