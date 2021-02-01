# Chris Grossack's zshrc
#
# This gets run on every computer I have, and it
# sources some ~bonus files~ based on what specific
# computer is running it. 
#
# See the rest of my dotfiles here:
# https://github.com/HallaSurvivor/dotfiles


#{{{ Export variables

#Set Editor
export EDITOR=/usr/bin/nvim

#Tell the world that we use UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

#Tell everyone where our dotfiles directory is
export DOTFILES=$HOME/dotfiles

#Tell cowsay where the cows are
export COWPATH=$DOTFILES/bin/cows

#Fix gpg
export GPG_TTY=$(tty)

#}}}

#{{{ Zsh options

# We want globbing to be case insensitive.
# Life is too short to hit shift every time I cd into Documents
setopt NO_CASE_GLOB

# I used to have an alias for .. = cd .. 
# but no longer!
# If we type a directory with no command, assume we wanted to cd
setopt AUTO_CD

# We make mistakes sometimes. Why not enable a weak autocorrect?
setopt CORRECT
setopt CORRECT_ALL

# We're gay. Give us colors
autoload -U colors && colors

#}}}

#{{{ Autocomplete stuff

# A lot of this is black magic, and is shamelessly stolen
# from various places including
#
# https://scriptingosx.com/2019/07/moving-to-zsh-part-5-completions/

# again, we're gay. show colors when able
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# case insensitive path-completion 
# that is, cd do will complete to Documents, Downloads, and dotfiles
zstyle ':completion:*' matcher-list \
  'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
  'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' \
  'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' \
  'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 

# partial completion suggestions
# that is, cd Do/San/ will complete to cd Documents/Sandbox
zstyle ':completion:*' list-suffixes zstyle ':completion:*' expand prefix suffix 

# now that it's set up, let's enable autocomplete
autoload -Uz compinit && compinit

#}}}

#{{{ $PATH stuff

# This is where we add important directories to our $PATH

# This function is shamelessly taken from:
# http://superuser.com/questions/39751/add-directory-to-path-if-its-not-already-there
function path_add()
{
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="${PATH:+"$PATH:"}$1"
  fi
}

path_add "$DOTFILES/bin"

#}}}

#{{{ Some functions 

# note two functions ps1_on and ps1_off are defined in zsh/prompt 

# There are some places we go often
function cdd { cd ~/dotfiles; }
function cds { cd ~/Documents/sandbox; }
function cdr { cd ~/Dropbox/research; }
function cdw { cd ~/Dropbox/work/ucr; }

# reload zshrc
function reload { source ~/.zshrc; }

# for some reason there's no way to set your default regextype in find...
function findr { dir=$1; shift; find $dir -regextype posix-egrep $*; }

# Yes. I'm too lazy to type those extra two letters
alias g=git

# Again. I'm actually this lazy
alias v=nvim

# I think this is cute. Ask politely if you forget to sudo
alias pls='sudo $(history -p !!)'

#}}}

source $DOTFILES/zsh/prompt

case $(hostname) in
  (Smeargle*)   source $DOTFILES/zsh/zshrc.smeargle;;
  (Feraligatr*) source $DOTFILES/zsh/zshrc.feraligatr;;
  (*) echo "You should add this computer to your zshrc!";;
esac
