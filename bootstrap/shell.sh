#!/usr/bin/env bash

cd /tmp

git clone https://github.com/belimawr/dotfiles.git
cp -rT /tmp/dotfiles $HOME
cd $HOME
rm -rf .git README.md LICENSE
git clone https://github.com/belimawr/.emacs.d.git
rm -rf /tmp/dotfiles

cd $HOME
mkdir -p $HOME/Software/
cd $HOME/Software/
wget -q https://redirector.gvt1.com/edgedl/go/go1.9.2.linux-amd64.tar.gz
tar -xf go1.9.2.linux-amd64.tar.gz
rm go1.9.2.linux-amd64.tar.gz
