# wukong-robot-install-script

[wukong-robot](https://github.com/wzpan/wukong-robot) 项目的一键安装脚本

#### 用法:
```shell
sudo wget http://wukong-install.oss-cn-hangzhou.aliyuncs.com/install.sh && sudo chmod 777 install.sh &&./install.sh
```

#### 说明 for Mac/Linux:
1. 目前本项目只能用于MacOS/Linux/树莓派(Raspbian)系统的一键安装（仅在mac、Ubuntu16.04和树莓派(Raspbian)下测试通过
2. 安装目录位于 ~/wukong-robot/
3. 默认使用阿里云的源进行安装，如有问题请切换到github源进行安装
4. 如遇到未知bug，请提Issues

#### 说明 for raspberrypi:      
1. 树莓派使用前请先换源，如果不知道怎么换源请执行以下命令:
```shell
sudo wget http://wukong-install.oss-cn-hangzhou.aliyuncs.com/changeSource.sh && sudo chmod 777 changeSource.sh &&./changeSource.sh
```
2. 增加选择录音和播放设备功能，如需使用请执行以下命令:
```shell
sudo wget http://wukong-install.oss-cn-hangzhou.aliyuncs.com/choiceDevice.py && sudo python3 choiceDevice.py
```

