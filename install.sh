#!/bin/sh

cp -rf .vim .vimrc $HOME
sudo cp rdm.service  rdm.socket /lib/systemd/system
sudo systemctl enable rdm
sudo systemctl start rdm
echo "install ok"

