#!/bin/bash

wget https://logictronix.com/wp-content/uploads/2024/06/kria-ubuntu-kernel-build-1027.zip
unzip kria-ubuntu-kernel-build-1027.zip
cd kernel_build_1027
sudo dpkg -i *.deb

#bash install.sh
