#!/bin/sh

set -eu

if [ ! "$0" -ef ~/.config/install.sh ]; then
	echo "Repository must be linked to ~/.config." >&2
	exit 1
fi

# Dash
if [ ! -f ~/.profile ]; then
	echo 'export ENV=$HOME/.config/dash/rc' > ~/.profile
	echo '. ~/.config/dash/profile' >> ~/.profile
fi

# zsh
[ -f ~/.zshrc ] || echo 'for i (~/.config/zsh/*.zsh) source $i' > ~/.zshrc

# Neovim
dir=$HOME/.local/share/nvim/bundle/repos/github.com/Shougo
mkdir -p $dir
git -C $dir/dein.vim pull || \
	git clone https://github.com/Shougo/dein.vim $dir/dein.vim

# tmux
ln -fs ~/.config/tmux/tmux.conf ~/.tmux.conf
dir=$HOME/.local/share/tmux/plugins
mkdir -p $dir
git -C $dir/tpm pull || \
	git clone https://github.com/tmux-plugins/tpm $dir/tpm

# git
[ -f ~/.gitconfig ] || \
	echo "[include]\n\tpath = .config/git/gitconfig" > ~/.gitconfig

# GnuPG
mkdir -p ~/.gnupg
chmod 0700 ~/.gnupg
chmod -R u=rwX,g=,o= ~/.config/gnupg
[ -e ~/.gnupg/gpg.conf ] || ln -s ~/.config/gnupg/gpg.conf ~/.gnupg/gpg.conf
