# GPIO
- [電源LEDにハートビート設定](#heartbeat)

## <a id="heartbeat">電源LEDにハートビート設定</a>
```sh
sudo su -
echo "dtparam=pwr_led_trigger=heartbeat" >> /boot/config.txt
```
