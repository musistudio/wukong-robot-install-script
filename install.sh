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
        sudo pip3 install --upgrade pip
        sudo pip3 install pyaudio
        cd ~/wukong-robot
        pip3 install -r requirements.txt
        git clone ${snowboy} ~/snowboy
        cd ~/snowboy/swig/Python3
        make
        sudo cp _snowboydetect.so ~/wukong-robot/snowboy/
        sudo rm -rf ~/snowboy
        sudo chmod -R 777 ~/wukong-robot/
    elif [[ $os == "linux" ]]
    then
        echo "正在为您安装wukong-robot,安装目录~/wukong-robot/"
        sudo apt-get update && sudo apt-get upgrade -y
        sudo git clone ${wukong} ~/wukong-robot
        sudo apt-get install python3 python3-pip python-pyaudio python3-pyaudio sox pulseaudio libsox-fmt-all ffmpeg
        sudo pip3 install --upgrade pip
        sudo pip3 install pyaudio distribute
        cd ~/wukong-robot
        sudo pip3 install -r requirements.txt
        sudo apt-get install python3-dev
        sudo apt-get install python3-all-dev
        sudo mkdir ~/install_temp && cd ~/install_temp
        sudo wget http://hahack-1253537070.file.myqcloud.com/misc/swig-3.0.10.tar.gz
        sudo tar xvf swig-3.0.10.tar.gz
        cd swig-3.0.10
        sudo apt-get install -y libpcre3 libpcre3-dev
        ./configure --prefix=/usr --without-clisp --without-maximum-compile-warnings
        sudo make && sudo make install
        sudo install -v -m755 -d /usr/share/doc/swig-3.0.10
        sudo cp -v -R Doc/* /usr/share/doc/swig-3.0.10
        sudo apt-get install -y libatlas-base-dev
        sudo git clone ${snowboy} ~/snowboy
        cd ~/snowboy/swig/Python3
        sudo make
        sudo cp _snowboydetect.so ~/wukong-robot/snowboy/
        sudo rm -rf ~/install_temp/ ~/snowboy/
        sudo chmod -R 777 ~/wukong-robot/
    elif [[ $os == "raspberrypi" ]]
    then
        echo "正在为您安装wukong-robot,安装目录~/wukong-robot/"
        sudo apt-get update && sudo apt-get  -y upgrade
        sudo git clone ${wukong} ~/wukong-robot
        sudo apt-get install -y python3 python3-pip python-pyaudio python3-pyaudio sox pulseaudio libsox-fmt-all ffmpeg
        sudo pip3 install --upgrade pip
        cd ~/wukong-robot
        sudo pip3 install -r requirements.txt
        sudo apt-get install -y python3-dev python3-all-dev
        sudo mkdir ~/install_temp && cd ~/install_temp
        sudo wget http://hahack-1253537070.file.myqcloud.com/misc/swig-3.0.10.tar.gz
        sudo tar xvf swig-3.0.10.tar.gz
        cd swig-3.0.10
        sudo apt-get install -y libpcre3 libpcre3-dev libatlas-base-dev
        ./configure --prefix=/usr --without-clisp --without-maximum-compile-warnings
        sudo make && sudo make install
        sudo install -v -m755 -d /usr/share/doc/swig-3.0.10
        sudo cp -v -R Doc/* /usr/share/doc/swig-3.0.10
        sudo git clone ${snowboy} ~/snowboy
        cd ~/snowboy/swig/Python3
        sudo make
        sudo cp _snowboydetect.so ~/wukong-robot/snowboy/
        sudo rm -rf ~/install_temp/ ~/snowboy/
        sudo chmod -R 777 ~/wukong-robot/
    elif [[ $os == "win10" ]]
    then
        echo "正在为您安装wukong-robot,安装目录~/wukong-robot/"
        sudo add-apt-repository ppa:therealkenc/wsl-pulseaudio
        sudo apt-get update && sudo apt-get upgrade -y
        sudo git clone ${wukong} ~/wukong-robot
        sudo apt-get install python3 python3-pip python-pyaudio python3-pyaudio sox pulseaudio libsox-fmt-all ffmpeg
        sudo pip3 install --upgrade pip
        sudo pip3 install pyaudio distribute
        cd ~/wukong-robot
        sudo pip3 install --upgrade --ignore-installed -r requirements.txt
        sudo apt-get install python3-dev
        sudo apt-get install python3-all-dev
        sudo mkdir ~/install_temp && cd ~/install_temp
        sudo wget http://hahack-1253537070.file.myqcloud.com/misc/swig-3.0.10.tar.gz
        sudo tar xvf swig-3.0.10.tar.gz
        cd swig-3.0.10
        sudo apt-get install -y libpcre3 libpcre3-dev
        ./configure --prefix=/usr --without-clisp --without-maximum-compile-warnings
        sudo make && sudo make install
        sudo install -v -m755 -d /usr/share/doc/swig-3.0.10
        sudo cp -v -R Doc/* /usr/share/doc/swig-3.0.10
        sudo apt-get install -y libatlas-base-dev
        sudo git clone ${snowboy} ~/snowboy
        cd ~/snowboy/swig/Python3
        sudo make
        sudo cp _snowboydetect.so ~/wukong-robot/snowboy/
        sudo rm -rf ~/install_temp/ ~/snowboy/
        sed -i '$a export PULSE_SERVER=tcp:localhost' ~/.bashrc
        source ~/.bashrc
        sudo chmod -R 777 ~/wukong-robot/
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
    if [[ ${confirm} != "Y" && ${confirm} != "y" && ${confirm} != "" ]]
    then
        echo "系统检测错误，已退出安装，请反馈给作者"
        exit
    else
        install_wukong "macos"
    fi
elif [[ ${os_name[0]} == "Linux" && ${os_name[1]} == "raspberrypi" ]]
then   
    read -p "您的系统是否为Raspbian? [Y/n]:" confirm    
    if [[ ${confirm} != "Y" && ${confirm} != "y" && ${confirm} != "" ]]
    then                      
        echo "系统检测错误，已退出安装，请反馈给作者"
        exit                  
    else                      
        install_wukong "raspberrypi"
    fi 
elif [[ ${os_name[0]} == "Linux" && ${os_name[2]} =~ "Microsoft" ]]
then   
    read -p "您的系统是否为win10子系统? [Y/n]:" confirm    
    if [[ ${confirm} != "Y" && ${confirm} != "y" && ${confirm} != "" ]]
    then                 
        echo "系统检测错误，已退出安装，请反馈给作者"
        exit             
    else
        install_wukong "win10"
    fi
elif [[ ${os_name[0]} == "Linux" && ${os_name[1]} != "raspberrypi" ]]
then
    if [[ ${confirm} != "Y" && ${confirm} != "y" && ${confirm} != "" ]]
    then                                                                                                                   
        echo "系统检测错误，已退出安装，请反馈给作者"
        exit
    else
        install_wukong "linux"
    fi
fi
