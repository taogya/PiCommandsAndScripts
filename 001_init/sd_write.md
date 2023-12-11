# SDカード書き込み
```sh
$ diskutil list
 :
/dev/disk4 (external, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        *15.7 GB    disk4
   1:                        EFI EFI                     209.7 MB   disk4s1
   2:       Microsoft Basic Data BOOTFS                  15.5 GB    disk4s2

$ diskutil umountDisk /dev/disk4
Unmount of all volumes on disk4 was successful

$ sudo dd if=/Users/"$(whoami)"/Downloads/ImageFile/raspi_backup.img of=/dev/disk4 bs=1m
```
