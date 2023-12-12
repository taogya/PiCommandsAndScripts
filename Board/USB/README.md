# USB
- [USB Ether Gadgetの設定](#usb_ether)

## <a id="usb_ether">USB Ether Gadgetの設定</a>
```sh
sudo su -
echo "dtoverlay=dwc2" >> /boot/config.txt
sed -i "s/rootwait/rootwait modules-load=dwc2,g_ether/g" /boot/cmdline.txt
```
