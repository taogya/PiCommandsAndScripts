# GPIO
- [電源LEDにハートビート設定](#heartbeat)

## <a id="heartbeat">電源LEDにハートビート設定</a>
```sh
sudo su -
if ! grep "dtparam=pwr_led_trigger=heartbeat" /boot/config.txt > /dev/null 2>&1 ; then
    echo "dtparam=pwr_led_trigger=heartbeat" >> /boot/config.txt
fi
```
