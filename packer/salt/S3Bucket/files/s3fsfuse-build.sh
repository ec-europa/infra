#!/bin/bash -e

echo {{ grains['s3_aws_access_key'] }}:{{ grains['s3_aws_secret_key'] }} > ~/.passwd-s3fs
chmod 600 ~/.passwd-s3fs
git clone https://github.com/s3fs-fuse/s3fs-fuse.git
cd s3fs-fuse
bash autogen.sh > install.txt
./configure >> install.txt
make >> install.txt
make install >> install.txt
mkdir -p /mnt/s3fs/joinup

