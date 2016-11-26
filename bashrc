# Christopher Grossack's bashrc. 
#
# Additional files (functions and bashrc.private) are sourced
# at the bottom of this file. This file is responsible for:
# 
# * Defining global vars
# * Exporting the PS1 (terminal prompt)
# * Defining the function to build $PATH
#
# See the rest of my dotfiles here:
# https://github.com/HallaSurvivor/dotfiles

###############
# Define Vars #
###############
#Set Editor
export EDITOR=/usr/bin/vim

#Tell the world we're 256 color
export TERM=screen-256color

#Tell the world that we use UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

##############
# Build PATH #
##############

#This function is shamelessly taken from:
#http://superuser.com/questions/39751/add-directory-to-path-if-its-not-already-there
function _path_add()
{
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="${PATH:+"$PATH:"}$1"
  fi
}

# The path is actually updated in bashrc.private, since it isn't universal.

#############
# Build PS1 #
#############

#This function is shamelessly taken almost directly from:
#http://www.opinionatedprogrammer.com
#  /2011/01/colorful-bash-prompt-reflecting-git-status/
function _git_prompt() {
  local git_status="`git status -unormal 2>&1`"
  if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
    if [[ "$git_status" =~ nothing\ to\ commit ]]; then
      local ansi=46
    elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
      local ansi=43
    else
      local ansi=45
    fi
    if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
      branch=${BASH_REMATCH[1]}
      test "$branch" != master || branch=' '
    else
      # Detached HEAD.  (branch=HEAD is a faster alternative.)
      branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null ||
        echo HEAD`)"
    fi
    echo -n '\[\e[0;37;'"$ansi"';1m\]'"$branch"'\[\e[0m\] '
fi
}

# This function is inspired by the code here:
# https://gist.github.com/miki725/9783474
function _venv_prompt() {
  if [ -n "$VIRTUAL_ENV" ]; then
    echo -n "(`basename \"$VIRTUAL_ENV\"`) "
  fi
}

function _prompt_command() {
  PS1="`_git_prompt``_venv_prompt`"'\u@\h: \W> '
}

PROMPT_COMMAND=_prompt_command

###########################
# Source Additional Files #
###########################

if [ -e "$HOME/.functions" ]
then
  source $HOME/.functions
fi

if [ -e "$HOME/.bashrc.private" ]
then
  source $HOME/.bashrc.private
fi
