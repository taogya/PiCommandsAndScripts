# Bluetooth
- [Bluetoothサービスのエラー抑制](#suppress_error)

## <a id="suppress_error">Bluetoothサービスのエラー抑制</a>
```sh
sed -i 's|ExecStart=/usr/libexec/bluetooth/bluetoothd|ExecStart=/usr/libexec/bluetooth/bluetoothd --noplugin=sap|g' /lib/systemd/system/bluetooth.service
mkdir -p /etc/systemd/system/bthelper@.service.d/
echo -n '
[Unit]
After=hciuart.service bluetooth.service
Before=
 
[Service]
ExecStartPre=/bin/sleep 5
' > /etc/systemd/system/bthelper@.service.d/override.conf
systemctl daemon-reload
systemctl restart bluetooth.service
```