#!/bin/sh

BASE_DIR=$(realpath $(dirname "$0"))
CONFIG_DIR=$HOME/.config

rm -rf $CONFIG_DIR/zsh
rm -f $HOME/.zshrc

ln -sf $BASE_DIR $CONFIG_DIR
ln -sf $BASE_DIR/zshrc $HOME/.zshrc

exit 0
