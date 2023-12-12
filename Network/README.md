# Network
- [Wi-Fi](Wi-Fi/README.md)
- [IPv6無効化](#disable_ipv6)

## <a id="disable_ipv6">IPv6無効化</a>
```sh
switch_to_1(){
  tag="${1}"
    
  if ! grep "^${tag}" /etc/sysctl.conf > /dev/null 2>&1 ; then
    echo "${tag} = 1" >> /etc/sysctl.conf
  else
    sed -i "s/^${tag} = 0$/${tag} = 1/g" /etc/sysctl.conf
  fi
}

switch_to_1 net.ipv6.conf.all.disable_ipv6
switch_to_1 net.ipv6.conf.default.disable_ipv6
sysctl -p
```