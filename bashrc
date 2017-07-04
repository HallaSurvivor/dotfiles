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

###########################
# Source Additional Files #
###########################

if [ -e "$HOME/.functions" ]
then
  source $HOME/.functions
fi

if [ -e "$HOME/.prompt" ]
then
  source $HOME/.prompt
fi

if [ -e "$HOME/.bashrc.private" ]
then
  source $HOME/.bashrc.private
fi
