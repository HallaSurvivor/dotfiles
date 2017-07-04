# Christopher Grossack's bashrc. 
#
# Additional files are sourced at the bottom of this file. 
# This file is responsible for:
# 
# * Defining global vars
# * Building $PATH
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

#Tell everyone where our dotfiles directory is
export DOTFILES=$HOME/dotfiles

#Tell cowsay where the cows are
export COWPATH=$DOTFILES/bin/cows

##############
# Build PATH #
##############

#This function is shamelessly taken from:
#http://superuser.com/questions/39751/add-directory-to-path-if-its-not-already-there
function path_add()
{
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="${PATH:+"$PATH:"}$1"
  fi
}

path_add "$DOTFILES/bin"

###########################
# Source Additional Files #
###########################

if [ -e "$DOTFILES/functions" ];
then
  source $DOTFILES/functions
fi

if [ -e "$DOTFILES/prompt" ];
then
  source $DOTFILES/prompt
fi
