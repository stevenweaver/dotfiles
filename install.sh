git submodule init && git submodule update
#virtualenv ~/.neovimpython
rm ~/.config; ln -sf ~/.dotfiles/.config ~/.config
rm ~/.bashrc; ln -sf ~/.dotfiles/.bashrc ~/.bashrc
rm ~/.vimrc; ln -sf ~/.dotfiles/.vimrc ~/.vimrc
rm ~/.vim; ln -sf ~/.dotfiles/.vim ~/.vim
rm ~/.tmux.conf; ln -sf ~/.dotfiles/.tmux.conf ~/.tmux.conf
rm ~/.zshrc; ln -sf ~/.dotfiles/.zshrc ~/.zshrc
rm ~/.gitconfig; ln -sf ~/.dotfiles/.gitconfig ~/.gitconfig
rm ~/.oh-my-zsh; ln -sf ~/.dotfiles/ohmyzsh ~/.oh-my-zsh
rm -rf ~/.newsbeuter; ln -sf ~/.dotfiles/.newsbeuter ~/.newsbeuter
rm -rf ~/.jshintrc; ln -sf ~/.dotfiles/jshintrc ~/.jshintrc
rm -rf ~/.tern-project; ln -sf ~/.dotfiles/.tern-project ~/.tern-project
