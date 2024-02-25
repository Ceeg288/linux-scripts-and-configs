#!/bin/bash
initial_install=("wget" "zsh" "gpg" "curl" "vim" "tmux" "gcc" "git" "docker")
snap_installs=("postman" "nvim")

######## Installs ########

for package in "${apt_installs[@]}"
do
	sudo apt install $package
done

for snap_package in "${snap_installs[@]}"
do
	sudo snap install $snap_package
done

######## GPG keys and other install steps for various programs ########

## Sublime Text ##
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null;

## VS Code ##
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

## Rust ##
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

## Update ##
sudo apt update
sudo snap install sublime-text
sudo apt install code

## Oh my Zsh ##
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

