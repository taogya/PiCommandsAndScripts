# UART
- [ハードウェアUARTの有効化](#en_hardware_uart)
- [通信設定](#ex_com_settings)

## <a id="en_hardware_uart">ハードウェアUARTの有効化</a>
```sh
sudo su -
if ! grep "enable_uart=1" /boot/config.txt > /dev/null 2>&1 ; then
    echo "enable_uart=1" >> /boot/config.txt
fi
sed -i "s/console=serial0,115200 //g" /boot/cmdline.txt
```

## <a id="ex_com_settings">通信設定例</a>
| baudrate | data bit | stop bit | parity bit |
| -------- | -------- | -------- | ---------- |
| 9600bps  | 8bit     | 1bit     | none       |
```sh
sudo su -
# stty --help
stty -F /dev/ttyS0 9600 cs8 -cstopb -parity
```
