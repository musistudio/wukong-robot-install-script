import subprocess
import re

def getRecoedDevices():
    record_devices = []
    cmd = "arecord -l"
    result = subprocess.getoutput(cmd)
    record_names = re.findall('\[.*?\]', result, re.S)
    card_nums = re.findall('card (.*?):', result, re.S)
    device_nums = re.findall(', device (.*?):', result, re.S)
    for index, card_num in enumerate(card_nums):
        record_devices.append({"card_num": card_num, "device_num": device_nums[index],  "name": record_names[index * 2], "type": record_names[index * 2 + 1]})
    return record_devices

def getPlayDevices():
    play_devices = []
    cmd = "aplay -l"
    result = subprocess.getoutput(cmd)
    play_names = re.findall('\[.*?\]', result, re.S)
    card_nums = re.findall('card (.*?):', result, re.S)
    device_nums = re.findall(', device (.*?):', result, re.S)
    for index, card_num in enumerate(card_nums):
        play_devices.append({"card_num": card_num, "device_num": device_nums[index], "name": play_names[index * 2], "type": play_names[index * 2 + 1]})
    return play_devices

def write_file(record, play):
    temp = '''
pcm.!default {
    type asym
    playback.pcm {
        type plug
        slave.pcm \"hw:''' + play["card_num"] + ''',''' + play["device_num"] +  '''\"
    }
    capture.pcm {
        type plug
        slave.pcm \"hw:''' + record["card_num"] + ''',''' + record["device_num"] + '''\"
    }        
}

ctl.!default {
    type hw
    card ''' + record["card_num"] + '''
}
'''
    with open('/home/pi/.asoundrc', 'wb') as f:
        f.write(temp.encode('utf8'))
    print("写入文件成功!")
if __name__ == '__main__':
    subprocess.getoutput('touch /home/pi/.asoundrc')
    print("-------- 检测到您有如下录音设备 --------")
    record_devices = getRecoedDevices()
    play_devices = getPlayDevices()
    for index, record_device in enumerate(record_devices):
        print('{}. 名称:{}, 类型:{}, 卡片编号:{}, 设备编号:{}'.format(index, record_device['name'], record_device['type'], record_device['card_num'], record_device['device_num']))
    record_index = int(input("请输入设备前的序号:"))
    print("-------- 检测到您有如下播放设备 --------")
    for index, play_device in enumerate(play_devices):
        print('{}. 名称:{}, 类型:{}, 卡片编号:{}, 设备编号:{}'.format(index, play_device['name'], play_device['type'], play_device['card_num'], play_device['device_num']))
    play_index = int(input("请输入设备前的序号:"))
    write_file(record_devices[record_index], play_devices[play_index])
