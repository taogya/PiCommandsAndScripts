# SDカードのバックアップ
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
$ sudo dd if=/dev/disk4 of=/Users/"$(whoami)"/Downloads/ImageFile/raspi_backup.img bs=1m
```
