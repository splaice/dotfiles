.PHONY: all bash tmux screen git bin

all: bash tmux screen git bin

bash: ~/.bashrc ~/.bash_profile ~/.bashrc.d

~/.bashrc:
	ln -s .dotfiles/bashrc ~/.bashrc

~/.bash_profile:
	ln -s .dotfiles/bash_profile ~/.bash_profile

~/.bash_aliases:
	ln -s .dotfiles/bash_aliases ~/.bash_aliases

~/.bashrc.d:
	ln -s .dotfiles/bashrc.d ~/.bashrc.d

tmux: ~/.tmux.conf

~/.tmux.conf:
	ln -s .dotfiles/tmux.conf ~/.tmux.conf

screen: ~/.screenrc

~/.screenrc:
	ln -s .dotfiles/screenrc ~/.screenrc

git: ~/.gitconfig

~/.gitconfig:
	ln -s .dotfiles/gitconfig ~/.gitconfig

bin: ~/bin

~/bin:
	ln -s .dotfiles/bin ~/bin
