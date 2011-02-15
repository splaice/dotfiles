# Determine what kind of os we are using
OSNAME=$(uname)

# Determine if we are connected to a remote host via ssh
if [ -z "$SSH_CONNECTION" ] ; then
    REMOTE=0
else
    REMOTE=1
fi

# load .bashrc
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
