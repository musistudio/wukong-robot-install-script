# /bin/bash

sudo dpkg-reconfigure dash
version=`lsb_release -a`
OLD_IFS="$IFS"
IFS=":"
array=($version)
IFS="$OLD_IFS"
len=${#array[*]}
v=${array[$len-1]}

sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak && sudo mv /etc/apt/sources.list.d/raspi.list /etc/apt/sources.list.d/raspi.list.bak
echo 'deb http://mirrors.ustc.edu.cn/raspbian/raspbian/'$v' main contrib non-free rpi' | sudo tee /etc/apt/sources.list
echo 'deb http://mirrors.ustc.edu.cn/archive.raspberrypi.org/debian/'$v' main ui' | sudo tee /etc/apt/sources.list.d/raspi.list
echo "文件修改成功!"
sudo apt-get update && sudo apt-get -y upgrade
