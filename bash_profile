# Christopher Grossack's bash_profile.
#
# Most of the interesting things happen in bashrc.
#
# See the rest of my dotfiles here:
# https://github.com/HallaSurvivor/dotfiles

if [ -e "$HOME/.bashrc" ];
then
  source $HOME/.bashrc
fi

(echo "So much time and so little to do.";
 echo "Wait a minute. Strike that. Reverse it.";
 echo "~ Willy Wonka") | pysay -n -f turtle.cow
echo ""
echo ""

# Allow remote ssh display
if [[ -n $SSH_CONNECTION ]] ;
then
  export DISPLAY=:0
else
  xhost +si:localuser:chris > /dev/null
fi
