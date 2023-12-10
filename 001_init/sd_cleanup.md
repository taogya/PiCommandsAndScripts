# SDカード初期化
方法1. Raspberry Pi Imagerにて削除を行う。<br>
方法2. 以下のコマンドを実行。<br>
```sh
$ diskutil list
 :
/dev/disk4 (external, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:     FDisk_partition_scheme                        *15.7 GB    disk4
   1:             Windows_FAT_16 RECOVERY                2.4 GB     disk4s1
   2:                      Linux                         33.6 MB    disk4s5
   3:             Windows_FAT_32 boot                    268.4 MB   disk4s6
   4:                      Linux                         13.1 GB    disk4s7

$ diskutil umountDisk /dev/disk4
Unmount of all volumes on disk4 was successful

$ diskutil eraseDisk MS-DOS BOOTFS disk4
Started erase on disk4
Unmounting disk
Creating the partition map
Waiting for partitions to activate
Formatting disk4s2 as MS-DOS (FAT) with name BOOTFS
512 bytes per physical sector
/dev/rdisk4s2: 30260336 sectors in 1891271 FAT32 clusters (8192 bytes/cluster)
bps=512 spc=16 res=32 nft=2 mid=0xf8 spt=32 hds=255 hid=411648 drv=0x80 bsec=30289920 bspf=14776 rdcl=2 infs=1 bkbs=6
Mounting disk
Finished erase on disk4
```
