# Christopher Grossack's bash_profile.
#
# Most of the interesting things happen in bashrc.
# This file is responsible for:
# 
# * Sourcing bashrc from login shells

if [ -e ".bashrc" ]
then
  source .bashrc
fi
