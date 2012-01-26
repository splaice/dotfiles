.PHONY: all

all: ~/.bashrc ~/.bashrc_linux ~/.bashrc_darwin ~/.bash_profile \
	~/.tmux.conf ~/.gitconfig  ~/.ssh/config ~/.ssh/environment \
	~/.path.d ~/.env.d ~/.path.d/stub.sh ~/.env.d/stub.sh

~/.bashrc: bashrc
	@install -m 0644 $? $@

~/.bashrc_darwin: bashrc_darwin
	@install -m 0644 $? $@

~/.bashrc_linux: bashrc_linux
	@install -m 0644 $? $@

~/.bash_profile: bash_profile
	@install -m 0644 $? $@

~/.bash_aliases: bash_aliases
	@install -m 0644 $? $@

~/.tmux.conf: tmux.conf
	@install -m 0644 $? $@

~/.gitconfig: gitconfig
	@install -m 0644 $? $@

~/.ssh/config: ssh/config
	@install -m 0644 $? $@

~/.ssh/environment: ssh/environment
	@install -m 0644 $? $@

~/.path.d:
	@install -d -m 0755 $@

~/.path.d/stub.sh: .path.d/stub.sh
	@install -m 0644 $? $@

~/.env.d:
	@install -d -m 0755 $@

~/.env.d/stub.sh: .env.d/stub.sh
	@install -m 0644 $? $@
