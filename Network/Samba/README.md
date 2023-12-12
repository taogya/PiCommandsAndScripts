# Samba
- [インストール](#install)
- [共有フォルダ作成](#create)

## <a id="install">インストール</a>
```sh
apt-get install -y samba

# global設定
sed -i "/^\[global\]$/a \\    dos charset = CP932" /etc/samba/smb.conf
sed -i "/^\[global\]$/a \\    unix charset = UTF8" /etc/samba/smb.conf
sed -i "/^\[global\]$/a \\    min protocol = SMB2 " /etc/samba/smb.conf
sed -i "/^\[global\]$/a \\    max protocol = SMB2" /etc/samba/smb.conf
sed -i "/^\[global\]$/a \\    veto files = /.*/" /etc/samba/smb.conf
```

## <a id="create">共有フォルダ作成</a>
```sh
SMB_USER=samba
SMB_DIR=/home/"${SMB_USER}"

# ユーザー追加
useradd -m "${SMB_USER}"

# 共有ディレクトリ設定
echo -n "[${SMB_USER}]
    comment = Samba Shared Folder
    path = ${SMB_DIR}
    guest ok = no
    read only = no
    browsable = yes
    writable = yes
    create mask = 0644
    directory mask = 0755
" >> /etc/samba/smb.conf

service smbd restart
smbpasswd -a "${SMB_USER}"
```
