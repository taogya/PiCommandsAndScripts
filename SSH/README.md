# SSH
- [接続設定](#connection)

## <a id="connection">接続設定</a>
```sh
SSH_PORT=22
SSH_ROOT_EN=no
SSH_PUBKEY_EN=yes
SSH_PASS_EN=no
SSH_KEY_PATH=.ssh/authorized_keys}
SSH_CONF_PATH=/etc/ssh/sshd_config.d/sshd.conf

echo -n "
Port ${SSH_PORT}
PermitRootLogin ${SSH_ROOT_EN}
PubkeyAuthentication ${SSH_PUBKEY_EN}
PasswordAuthentication ${SSH_PASS_EN}
AuthorizedKeysFile ${SSH_KEY_PATH}
" > "${SSH_CONF_PATH}"

systemctl restart sshd
```