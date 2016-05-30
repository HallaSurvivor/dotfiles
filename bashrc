if [ -e ".bashrc_local" ]
then
  source .bashrc_local
fi

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

######################
# Convenient Aliases #
######################

#refresh .bashrc in a terminal
alias reload="source ~/.bashrc"

#See hidden files
alias la="ls -a"

#Fix coin to wrap properly
alias coin="rlwrap coin"

#Interesting command to see top 10 called commands
alias checkHistory="history | awk '{print \$2}' | awk 'BEGIN {FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail | sort -nr"

#Force 256 color tmux
alias tmux="tmux -2"

#Use default tmux config
alias tdef="tmux source-file ~/.tmux/default"

#Make vim open quickly in tmux
alias vim="vim -X"

#update a git repo
alias update="git add -u; git status"

#############
# Functions #
#############

#mkdir then cd immediately
function mcd
{
  mkdir -p $1
  cd $1
}

#extract any file.
#shamelessly taken from github.com/xvoland/Extract/blob/master/extract.sh
function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
 else
    if [ -f "$1" ] ; then
        NAME=${1%.*}
        #mkdir $NAME && cd $NAME
        case "$1" in
          *.tar.bz2)   tar xvjf ./"$1"    ;;
          *.tar.gz)    tar xvzf ./"$1"    ;;
          *.tar.xz)    tar xvJf ./"$1"    ;;
          *.lzma)      unlzma ./"$1"      ;;
          *.bz2)       bunzip2 ./"$1"     ;;
          *.rar)       unrar x -ad ./"$1" ;;
          *.gz)        gunzip ./"$1"      ;;
          *.tar)       tar xvf ./"$1"     ;;
          *.tbz2)      tar xvjf ./"$1"    ;;
          *.tgz)       tar xvzf ./"$1"    ;;
          *.zip)       unzip ./"$1"       ;;
          *.Z)         uncompress ./"$1"  ;;
          *.7z)        7z x ./"$1"        ;;
          *.xz)        unxz ./"$1"        ;;
          *.exe)       cabextract ./"$1"  ;;
          *)           echo "extract: '$1' - unknown archive method" ;;
        esac
    else
        echo "'$1' - file does not exist"
    fi
fi
}

#############
# Build PS1 #
#############

#This function is taken almost directly from:
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

function _prompt_command() {
  PS1="`_git_prompt`"'\u@\h: \W> '
}

PROMPT_COMMAND=_prompt_command
