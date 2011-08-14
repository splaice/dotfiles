.PHONY: all

all: ~/.bashrc ~/.bash_profile ~/.bashrc.d ~/.tmux.conf ~/.screenrc \
	~/.gitconfig ~/bin ~/.ssh/config ~/.ssh/environment

~/.bashrc:
	ln -s .dotfiles/bashrc ~/.bashrc

~/.bash_profile:
	ln -s .dotfiles/bash_profile ~/.bash_profile

~/.bash_aliases:
	ln -s .dotfiles/bash_aliases ~/.bash_aliases

~/.bashrc.d:
	ln -s .dotfiles/bashrc.d ~/.bashrc.d

~/.tmux.conf:
	ln -s .dotfiles/tmux.conf ~/.tmux.conf

~/.screenrc:
	ln -s .dotfiles/screenrc ~/.screenrc

~/.gitconfig:
	ln -s .dotfiles/gitconfig ~/.gitconfig

~/bin:
	ln -s .dotfiles/bin ~/bin

~/.ssh/config:
	ln -s .dotfiles/ssh/config ~/.ssh/config

~/.ssh/environment:
	ln -s .dotfiles/ssh/environment ~/.ssh/environment
