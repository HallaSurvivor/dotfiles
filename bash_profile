# Christopher Grossack's bash_profile.
#
# Most of the interesting things happen in bashrc.
#
# See the rest of my dotfiles here:
# https://github.com/HallaSurvivor/dotfiles

(echo "So much time and so little to do.";
 echo "Wait a minute. Strike that. Reverse it.";
 echo "~ Willy Wonka") | pysay -n -f turtle.cow
echo ""
echo ""

if [ -e "$HOME/.bashrc" ];
then
  source $HOME/.bashrc
fi
