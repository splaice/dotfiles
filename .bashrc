# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

if [ -d /usr/local/Cellar/python/2.7.1/bin ] ; then
    PYBINPATH=/usr/local/Cellar/python/2.7.1/bin
elif [ -d /usr/local/Cellar/python/2.7/bin ] ; then
    PYBINPATH=/usr/local/Cellar/python/2.7/bin
else
    PYBINPATH=""
fi

export PATH=$PYBINPATH:/usr/local/bin:/usr/local/sbin:$PATH:$HOME/bin
export MANPATH=$MANPATH:/opt/local/man
export EDITOR=vim
export VISUAL=vim
export DISPLAY=:0.0
export CLICOLOR=1
export LSCOLORS=dxfxcxdxbxegedabagacad

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# Set default debian color font if it is supported
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is a computer i work from set prompt that make it obvious
# (hostname ending with .local identifier works good enough)
if [[ "$(hostname)" == *.local ]] ; then
	PS1="\[\e[7;32m\]\u@\h \W$\[\e[m\] "
fi

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
fi

# bash completion settings (actually, these are readline settings)
bind "set completion-ignore-case on" # note: bind is used instead of setting these in .inputrc.
									 # This ignores case in bash completion
bind "set bell-style none" # No bell, because it's damn annoying
bind "set show-all-if-ambiguous On" # this allows you to automatically show completion without
									# double tab-ing
