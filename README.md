# wukong-robot-install-script

[wukong-robot](https://github.com/wzpan/wukong-robot) 项目的一键安装脚本

#### 用法:
```shell
sudo wget http://wukong-install.oss-cn-hangzhou.aliyuncs.com/install.sh && sudo chmod 777 install.sh &&./install.sh
```

#### 整体说明:
1. 目前本项目只能用于MacOS/Linux/树莓派(Raspbian)系统的一键安装（仅在mac、Ubuntu16.04和树莓派(Raspbian)下测试通过
2. 安装目录位于 ~/wukong-robot/
3. 默认使用阿里云的源进行安装，如有问题请切换到github源进行安装
4. 运行后如果出现**No module named 'xxx’** 可能是有pip3的网络原因引起的，请切换到 ~/wukong-robot/ 目录后执行以下命令:
```shell
sudo pip3 install -r requirements.txt 
```
如果是win10子系统，请执行以下命令:
```shell
sudo pip3 install --upgrade --ignore-installed -r requirements.txt
```
5. 如遇到bug，请提Issues

#### 说明 for raspberrypi:      
1. 树莓派使用前请先换源，如果不知道怎么换源请执行以下命令:
```shell
sudo wget http://wukong-install.oss-cn-hangzhou.aliyuncs.com/changeSource.sh && sudo chmod 777 changeSource.sh &&./changeSource.sh
```
对换源脚本进行了更新，使其支持最新版系统。开始会有个弹框，选**No**即可。


2. 增加选择录音和播放设备功能，如需使用请执行以下命令(Respeaker用户请不要使用此脚本):
```shell
sudo wget http://wukong-install.oss-cn-hangzhou.aliyuncs.com/choiceDevice.py && sudo python3 choiceDevice.py
```

### 说明 for WSL(win10的Ubuntu子系统):
1. win10子系统使用前需要在win10上开启pulseaudio-server      
    下载解压 [pulseaudio.zip](http://wukong-install.oss-cn-hangzhou.aliyuncs.com/pulseaudio.zip) 并在CMD里运行bin目录下的 pulseaudio.exe
2. 在子系统里(ubuntu)运行以下命令:
```shell
sudo wget http://wukong-install.oss-cn-hangzhou.aliyuncs.com/install.sh && sudo chmod 777 install.sh &&./install.sh
```

