# SSH
- [接続設定](#connection)

## <a id="connection">接続設定</a>
```sh
SSH_PORT=22
SSH_ROOT_EN=no
SSH_PUBKEY_EN=yes
# SSH_PASS_ENは，公開鍵設定確立後にコンフィグファイルをnoに書き換えることを推奨
SSH_PASS_EN=yes
SSH_KEY_PATH=.ssh/authorized_keys
SSH_CONF_PATH=/etc/ssh/sshd_config.d/sshd.conf
SSH_USER_HOME=
SSH_PUBKEY=

echo -n "
Port ${SSH_PORT}
PermitRootLogin ${SSH_ROOT_EN}
PubkeyAuthentication ${SSH_PUBKEY_EN}
PasswordAuthentication ${SSH_PASS_EN}
AuthorizedKeysFile ${SSH_KEY_PATH}
" > "${SSH_CONF_PATH}"

echo "${SSH_PUBKEY}" >> "${SSH_USER_HOME}"/.ssh/authorized_keys

systemctl restart sshd
```