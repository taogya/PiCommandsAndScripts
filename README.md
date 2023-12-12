# PiCommandsAndScripts
よく使うコマンドやシェルスクリプトなどのまとめ<br>
[setup_sample.sh](setup_sample.sh)は[Raspberry Pi Imager](https://www.raspberrypi.com/software/)で設定した項目に加えて設定するサンプルスクリプトです。<br>

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
| Color             | Code |
| ----------------- | ---- |
| #000000 (Black)   | 30   |
| #ff0000 (Red)     | 31   |
| #00ff00 (Green)   | 32   |
| #ffff00 (Yellow)  | 33   |
| #0000ff (Blue)    | 34   |
| #ff00ff (Magenta) | 35   |
| #00ffff (Cyan)    | 36   |
| #ffffff (White)   | 37   |
```sh
# rootに赤色を設定している例
sudo su -
echo -n "
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \$\[\033[00m\] '
" >> /root/.bashrc
```
