# Wi-Fi
- [クライアント設定](#client)
- [アクセスポイント追加](#add_ap)

## <a id="client">クライアント設定</a>
```sh
echo -n "allow-hotplug wlan0
iface wlan0 inet manual
wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf" > /etc/network/interfaces.d/wlan0
systemctl enable wpa_supplicant
systemctl start wpa_supplicant
```

## <a id="add_ap">アクセスポイント追加</a>
```sh
add_wifi_network(){
  ssid="${1}"
  pass="${2}"
  conf="${3:-/etc/wpa_supplicant/wpa_supplicant.conf}"

  ret="$(wpa_passphrase "${ssid}" "${pass}" | grep -v "#")"
  psk="$(echo "${ret}" | grep -E ".*psk=.*")"

  # 既に存在するSSIDなら
  if grep "ssid=\"${ssid}\"" "${conf}" > /dev/null 2>&1 ; then
    # 前パスワード削除して新パスワード追加
    sed -i "/sid=\"${ssid}\"$/ {n;d}" "${conf}"
    sed -i "/ssid=\"${ssid}\"$/a \\${psk}" "${conf}"
  # 存在しないなら末尾に追加
  else
    echo "${ret}" >> "${conf}"
  fi
}

add_wifi_network LiteRaspberryPi 2023060915441588
```