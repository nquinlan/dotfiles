#
# Path to your oh-my-zsh installation.
# export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="agnoster"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

# Keynindings
bindkey -e
bindkey \^u backward-kill-line

# User configuration

export PATH="$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

setopt append_history no_inc_append_history no_share_history
setopt no_hist_verify

# Load the shell dotfiles, and then some:
# * ~/.dotfiles/path can be used to extend `$PATH`.
# * ~/.dotfiles/extra can be used for other settings you don’t want to commit.
for file in ~/.dotfiles/{exports,path,aliases,extra,computer}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file


setopt prompt_subst
autoload -U colors && colors

parse_git_branch() {
    git symbolic-ref --short HEAD 2> /dev/null
}

git_info() {

  # Exit if not inside a Git repository
  ! git rev-parse --is-inside-work-tree > /dev/null 2>&1 && return

  # Git branch/tag, or name-rev if on detached head
  local GIT_LOCATION=${$(git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD)#(refs/heads/|tags/)}

  local UNTRACKED="%{$fg[red]%}●%{$reset_color%}"
  local MODIFIED="%{$fg[yellow]%}●%{$reset_color%}"
  local STAGED="%{$fg[green]%}●%{$reset_color%}"

  local FLAG=""

  if ! git diff --cached --quiet 2> /dev/null; then
    FLAG=( "$STAGED" )
  fi

  if ! git diff --quiet 2> /dev/null; then
    FLAG=( "$MODIFIED" )
  fi

  if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
    FLAG=( "$UNTRACKED" )
  fi

  local -a GIT_INFO
  GIT_INFO+=
  [ -n "$GIT_STATUS" ] && GIT_INFO+=( "$GIT_STATUS" )
  [ -n "$FLAG" ] && GIT_INFO+=( "$FLAG" )
  GIT_INFO+=( "%{\033[38;5;15m%}$GIT_LOCATION%{$reset_color%}" )
  echo "${(j: :)GIT_INFO}"

}

# Use ❯ as the non-root prompt character; # for root
# Change the prompt character color if the last command had a nonzero exit code
PS1='%{$fg[magenta]%}%~%u $(git_info) %(?.%{$fg[blue]%}.%{$fg[red]%})%(!.#.$)%{$reset_color%} '
# PROMPT='%9c($FLAG%{%F{green}%}$(parse_git_branch)%{%F{none}%})$ '

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
