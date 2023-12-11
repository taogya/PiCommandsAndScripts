# 電源LEDにハートビート設定
```sh
if ! grep "dtparam=pwr_led_trigger=heartbeat" /boot/config.txt > /dev/null 2>&1 ; then
    echo "dtparam=pwr_led_trigger=heartbeat" >> /boot/config.txt
fi
```
