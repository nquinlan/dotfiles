# User configuration
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"

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
