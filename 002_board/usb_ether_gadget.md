# USB Ether Gadgetの設定方法
```sh
if ! grep "dtoverlay=dwc2" /boot/config.txt > /dev/null 2>&1 ; then
    echo "dtoverlay=dwc2" >> /boot/config.txt
fi
if ! grep "modules-load=dwc2,g_ether" /boot/cmdline.txt > /dev/null 2>&1 ; then
    sed -i "s/rootwait/rootwait modules-load=dwc2,g_ether/g" /boot/cmdline.txt
fi
```
