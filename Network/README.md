# Network
- [Wi-Fi](Wi-Fi/README.md)
- [IPv6無効化](#disable_ipv6)

## <a id="disable_ipv6">IPv6無効化</a>
```sh
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
sysctl -p
```