# SD
基本的に[Raspberry Pi Imager](https://www.raspberrypi.com/software/)にてSD書き込みを行う。<br>
以下はターミナル上で行う場合のメモ。<br>
- [バックアップ](#backup)
- [フォーマット](#format)
- [書き込み](#write)

## <a id="backup">バックアップ</a>
```sh
# 対象のSDカードを選択
$ diskutil list
 :
/dev/disk4 (external, physical):
 :

$ diskutil umountDisk /dev/disk4
Unmount of all volumes on disk4 was successful

$ sudo dd if=/dev/disk4 of=/Users/"$(whoami)"/Downloads/ImageFile/raspi_backup.img bs=1m
```

## <a id="format">フォーマット</a>
```sh
# 対象のSDカードを選択
$ diskutil list
 :
/dev/disk4 (external, physical):
 :

$ diskutil umountDisk /dev/disk4
Unmount of all volumes on disk4 was successful

$ diskutil eraseDisk MS-DOS BOOTFS disk4
```

## <a id="write">書き込み</a>
```sh
# 対象のSDカードを選択
$ diskutil list
 :
/dev/disk4 (external, physical):
 :

$ diskutil umountDisk /dev/disk4
Unmount of all volumes on disk4 was successful

$ sudo dd if=/Users/"$(whoami)"/Downloads/ImageFile/raspi_backup.img of=/dev/disk4 bs=1m
```