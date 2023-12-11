# ハードウェアUARTの有効化
```sh
if ! grep "enable_uart=1" /boot/config.txt > /dev/null 2>&1 ; then
    echo "enable_uart=1" >> /boot/config.txt
fi
sed -i "s/console=serial0,115200 //g" /boot/cmdline.txt
```

# 通信設定(9600bps, data 8bit, stop 1bit, parity none)
```sh
stty -F /dev/ttyS0 9600 cs8 -cstopb -parity
```
