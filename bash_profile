# Christopher Grossack's bash_profile.
#
# Most of the interesting things happen in bashrc.
#
# See the rest of my dotfiles here:
# https://github.com/HallaSurvivor/dotfiles

if [ -e "$HOME/.bashrc" ]
then
  source $HOME/.bashrc
fi

eval `dircolors $HOME/.dircolors`
