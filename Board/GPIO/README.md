# GPIO
- [電源LEDにハートビート設定](#heartbeat)

## <a id="heartbeat">電源LEDにハートビート設定</a>
```sh
sudo su -
echo "dtparam=pwr_led_trigger=heartbeat" >> /boot/config.txt
```

## <a id="shutdown">シャットダウンボタン設定</a>
GPIO3ピンにスイッチを取り付けると，電源ON/OFF制御ができます。
```sh
sudo su -
echo "dtoverlay=gpio-shutdown,gpio_pin=3,active_low=1,gpio_pull=up,debounce=1000 >> /boot/config.txt
```
> GPIO3を使用する場合，i2cをOFFにする必要があります。 <br>
> ```sh
> sed -i "s/^dtparam=i2c_arm=on/#dtparam=i2c_arm=on/g" /boot/config.txt
> ```

> GPIO3以外を設定した場合，電源ON制御は使えなくなります。
