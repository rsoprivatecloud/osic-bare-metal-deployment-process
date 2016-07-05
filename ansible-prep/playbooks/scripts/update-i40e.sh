#!/bin/bash

if [ ! -f /usr/src/i40e-1.3.47.tar.gz ];
then
    echo "i40e-1.3.47.tar.gz not downloaded. Downloading..."
    cd /usr/src
    wget https://downloadmirror.intel.com/25720/eng/i40e-1.3.47.tar.gz
else
    echo "i40e-1.3.47.tar.gz already downloaded."
fi

apt-get update
apt-get install -y gcc make

cd /usr/src
tar xvzf /usr/src/i40e-1.3.47.tar.gz
cd /usr/src/i40e-1.3.47/src
make install
update-initramfs -u
