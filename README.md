# PiCommandsAndScripts
よく使うコマンドやシェルスクリプトなどのまとめ

- [Bluetooth](Bluetooth/README.md)
- [Board](Board/README.md)
- [Git](Git/README.md)
- [SD](SD/README.md)
- [SSH](SSH/README.md)
- [Raspberry Piの更新](#update)
- [プロンプトカラー](#prompt_color)

## <a id="update">Raspberry Piの更新</a>
```sh
sudo su -
apt-get update -y && \
apt-get upgrade -y && \
apt-get dist-upgrade -y && \
reboot now
```

## <a id="prompt_color">プロンプトカラー</a>
| Color                                         | Code |
| --------------------------------------------- | ---- |
| <span style="color: #000000">■</span> Black   | 30   |
| <span style="color: #ff0000">■</span> Red     | 31   |
| <span style="color: #00ff00">■</span> Green   | 32   |
| <span style="color: #ffff00">■</span> Yellow  | 33   |
| <span style="color: #0000ff">■</span> Blue    | 34   |
| <span style="color: #ff00ff">■</span> Magenta | 35   |
| <span style="color: #00ffff">■</span> Cyan    | 36   |
| <span style="color: #ffffff">■</span> White   | 37   |
```sh
# rootに赤色を設定している例
sudo su -
echo -n "
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \$\[\033[00m\] '
" >> /root/.bashrc
```