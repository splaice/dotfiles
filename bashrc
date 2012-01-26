# ~/.bashrc
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

UNAME=$(uname)
if [[ "$UNAME" == "Darwin" ]] ; then
    if [ -f ~/.bashrc_darwin ]; then
        source  ~/.bashrc_darwin
    fi
fi

if [[ "$UNAME" == "Linux" ]] ; then
    if [ -f ~/.bashrc_linux ]; then
        source  ~/.bashrc_linux
    fi
fi
if [ -f ~/.bashrc_local ]; then
    source  ~/.bashrc_local
fi

# colors
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
bakgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

function prompt_command() {
  local scm=""
  local changes=$txtblk$bakwht
  local branch=""
  # check for git
  if git status &> /dev/null; then
    branch="$(git branch --no-color | head -1 | cut -d' ' -f 2)"
    if git status -s | grep -q '^[[:space:]][MA] '; then
      changes=$txtblk$bakred
    fi
    scm="${changes}\] ${branch} ${txtrst}\]"
  fi

  # export PS1
  PS1=''"${HOST_COLOUR}"'\]\u@\h'"${txtrst}"'\]'"${scm}"' '"${txtwht}"'\]\w'"${txtrst}"'\]\n\$ '

  # set the title
  case "$TERM" in
  xterm*|rxvt*)
    echo -ne "\033]0;${USER}@$(hostname -s): ${PWD/$HOME/~}\007" ;;
  esac
}

if [[ "$REMOTE" -eq "0" ]] ; then
    HOST_COLOUR=$txtblk$bakgrn
else
    HOST_COLOUR=$txtblk$bakpur
fi
PROMPT_COMMAND=prompt_command

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    source  ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
    # bash completion settings (actually, these are readline settings)
    bind "set completion-ignore-case on" # note: bind is used instead of setting these in .inputrc.
                                         # This ignores case in bash completion
    bind "set bell-style none"           # No bell, because it's damn annoying
    bind "set show-all-if-ambiguous On"  # this allows you to automatically show completion without
                                         # double tab-ing
fi

if [ -d "$HOME/.env.d" ] ; then
    for env_file in $(ls -1 $HOME/.env.d/*.sh); do
      source $env_file
    done
fi

if [ -d "$HOME/.path.d" ] ; then
    for path_file in $(ls -1 $HOME/.path.d/*.sh); do
      source $path_file
    done
fi
