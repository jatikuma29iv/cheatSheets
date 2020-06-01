# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# jet - add tmux
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Jet
export PATH=$HOME/bin:$PATH:/usr/local/bin

# gcloud
CLOUDSDK_HOME=/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk

eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

countdn() { local i=$1; while [ "$i" -gt "0" ]; do printf "\r repeating after $i sec"; i=`expr $i - 1`; sleep 1; done; echo . }

alias cless="/usr/local/bin/ccat --color='always' | less -R"

# change k8s profile
function chk8shome() {
  local H=/home/jet/k8s/$1;

  [ ! -e $H ] && echo " invalid k8s home '$1'" && return 1;
  
  cd $H;
  export HOME=$H;
  export "J_HOME= \[\e[0;45m\]$1$SEGMENT_SEPARATOR%{$reset_color%}"
  export PATH=`echo $PATH | perl -pe "s|/home/.*?/bin:|${H}/bin:|"`;
  export KUBECONFIG=$H/.kube/config
  #func not working
  #export PS1=$(get_jhome $1 $PS1)
  export PS1="<$1>$PS1"
}

# add k8s home to prompt
#function get_jhome() {
#  local o
#  local h=$1
#
#  #echo "n $#"
#  #echo "jhome $h"
#  if [ -z $h ]
#  then
#    #echo "empty"
#    o=$1
#  else
#    #echo "not"
#    #local shorth=`hostname -s`
#
#    o=" \[\e[0;40m\]\[45m\]$h>\[$reset\]$2"
#    #o=`echo $2 | perl -pe "s|${shorth}|${shorth} ${h}|"`
#  fi
#
#  echo $o
#}
