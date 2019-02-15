import serial 
import json
from pynput.keyboard import Key, Listener


ser = serial.Serial("COM26", 115200, timeout=1)

print("****** Gardening / Agricultural Robot *******")
print("Controls")
print("w => Froward")
print("s => Backward")
print("d => Right")
print("a => Left")
print("e => Face Forward")
print("q => Stop")
print("x => Dig Hole")
print("z => Drop Seed")
print("esc key => close")

def on_press(key):
    key_str = str(key)
    if key_str == "'f'":
        with open('data.csv', 'a') as writeFile:
            ser.write(b'f')
            y = json.loads(ser.readline().decode("utf-8")[3:-4])
            data = str(y['val'])+","+input("Enter crop name ")+"\n"
            writeFile.write(data)
        print("Soil moisture level: "+str(y["val"]))
    if key_str == "'w'":
        ser.write(b'w')
    if key_str == "'s'":
        ser.write(b's')
    if key_str == "'a'":
        ser.write(b'a')
    if key_str == "'d'":
        ser.write(b'd')
    if key_str == "'q'":
        ser.write(b'q')
    if key_str == "'e'":
        ser.write(b'e')
    if key == Key.esc:
        writeFile.close()
        return False


with Listener(on_press=on_press) as listener:
    listener.join()