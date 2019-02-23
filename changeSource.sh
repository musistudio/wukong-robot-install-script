# /bin/bash

sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak && sudo mv /etc/apt/sources.list.d/raspi.list /etc/apt/sources.list.d/raspi.list.bak
echo 'deb http://mirrors.ustc.edu.cn/raspbian/raspbian/ stretch main contrib non-free rpi' | sudo tee /etc/apt/sources.list
echo 'deb http://mirrors.ustc.edu.cn/archive.raspberrypi.org/debian/ stretch main ui' | sudo tee /etc/apt/sources.list.d/raspi.list.bak
echo "文件修改成功!"
sudo apt-get update && sudo apt-get -y upgrade
