#!/bin/bash

install_wukong(){
    os=$1
    read -p "请选择安装源 [ALIYUN/github]:" source
    source=$(echo $source | tr 'A-Z' 'a-z')
    if [[ ${source} == "aliyun" || ${source} == "" ]]
    then
        wukong="https://code.aliyun.com/qingshanglishao/wukong-robot.git"
        snowboy="https://code.aliyun.com/qingshanglishao/snowboy.git"
    elif [[ $source == "github" ]]
    then
        wukong="https://github.com/wzpan/wukong-robot.git"
        snowboy="https://github.com/wzpan/snowboy.git"
    fi
    if [[ $os == "macos" ]]
    then
        echo "正在为您安装wukong-robot,安装目录~/wukong-robot/"
        sudo git clone ${wukong} ~/wukong-robot
        brew install portaudio sox ffmpeg swig
        pip3 install pyaudio
        cd ~/wukong-robot
        pip3 install -r requirements.txt
        git clone ${snowboy} ~/snowboy
        cd ~/snowboy/swig/Python3
        make
        sudo cp _snowboydetect.so ~/wukong-robot/snowboy/
        sudo rm -rf ~/snowboy
    elif [[ $os == "linux" ]]
    then
        echo "正在为您安装wukong-robot,安装目录~/wukong-robot/"
        sudo git clone ${wukong} ~/wukong-robot
        sudo apt-get install python-pyaudio python3-pyaudio sox pulseaudio libsox-fmt-all ffmpeg
        pip3 install pyaudio
        cd ~/wukong-robot
        pip3 install -r requirements.txt
        sudo apt-get install python3-dev
        sudo apt-get install python3-all-dev
        sudo mkdir ~/install_temp && cd ~/install_temp
        wget http://hahack-1253537070.file.myqcloud.com/misc/swig-3.0.10.tar.gz
        tar xvf swig-3.0.10.tar.gz
        cd swig-3.0.10
        sudo apt-get -y update
        sudo apt-get install -y libpcre3 libpcre3-dev
        ./configure --prefix=/usr --without-clisp --without-maximum-compile-warnings
        make && make install
        install -v -m755 -d /usr/share/doc/swig-3.0.10
        sudo cp -v -R Doc/* /usr/share/doc/swig-3.0.10
        sudo apt-get install -y libatlas-base-dev
        git clone ${snowboy} ~/snowboy
        cd ~/snowboy/swig/Python3
        make
        sudo cp _snowboydetect.so ~/wukong-robot/snowboy/
        sudo rm -rf ~/install_temp/ ~/snowboy/
    fi
clear
echo "wukong-robot已安装完成!"

} 


clear
echo "---------- 欢迎使用wukong-robot一键安装脚本 ----------"
echo "-------------- 作者：开机都不会的小小白---------------"
system=$(uname -a)
os_name=(${system// / })
if [ ${os_name[0]} == "Darwin" ]
then
    read -p "您的系统是否为MacOS? [Y/n]:" confirm
    echo $confirm
    if [[ ${confirm} == "Y" && ${confirm} != "y" && ${confirm} != "" ]]
    then
        echo "系统检测错误，已退出安装，请反馈给作者"
        exit
    else
        install_wukong "macos"
    fi
elif [[ ${os_name[0]} == "Linux" ]]
then
    read -p "您的系统是否为Linux? [Y/n]:" confirm
    if [[ ${confirm} != "Y" && ${confirm} != "y" && ${confirm} != "" ]]
    then
        echo "系统检测错误，已退出安装，请反馈给作者"
        exit
    else
        install_wukong "linux"
    fi
fi



