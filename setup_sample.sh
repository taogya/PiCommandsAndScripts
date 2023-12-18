#!/bin/bash

TARGET_USER=pi

GIT_USER=
GIT_MAIL=
GIT_SECRET_KEY=

SSH_CONF_PATH=/etc/ssh/sshd_config.d/sshd.conf
SSH_PORT=22
SSH_ROOT_EN=no
SSH_PUBKEY_EN=yes
# SSH_PASS_ENは，公開鍵設定確立後にコンフィグファイルをnoに書き換えることを推奨
SSH_PASS_EN=yes
SSH_PUBKEY=

SMB_USER=samba
SMB_DIR=/home/"${SMB_USER}"
SMB_ACCESS_PASS=samba

switch_value(){
  tag="${1}"
  path="${2}"
  before=${3}
  after=${4}
    
  if ! grep "^${tag}" "${path}" > /dev/null 2>&1 ; then
    echo "${tag} = ${after}" >> "${path}"
  else
    sed -i "s/^${tag} = ${before}$/${tag} = ${after}/g" "${path}"
  fi
}

add_if_not_exists(){
  val=${1}
  path=${2}
  
  if ! grep "${val}" "${path}" > /dev/null 2>&1 ; then
      echo "${val}" >> "${path}"
  fi
}

# ==================== Bluetooth ====================
suppress_bluetooth_error(){
  sed -i 's|^ExecStart=/usr/libexec/bluetooth/bluetoothd$|ExecStart=/usr/libexec/bluetooth/bluetoothd --noplugin=sap|g' /lib/systemd/system/bluetooth.service
  mkdir -p /etc/systemd/system/bthelper@.service.d/
  echo -n '
[Unit]
After=hciuart.service bluetooth.service
Before=

[Service]
ExecStartPre=/bin/sleep 5
' > /etc/systemd/system/bthelper@.service.d/override.conf
}

# ==================== Board ====================
# -------------------- GPIO --------------------
setup_heartbeat(){
  add_if_not_exists "dtparam=pwr_led_trigger=heartbeat" /boot/config.txt
}

setup_shutdown(){
  if ! grep "dtoverlay=gpio-shutdown" /boot/config.txt > /dev/null 2>&1 ; then
      echo "dtoverlay=gpio-shutdown,gpio_pin=3,active_low=1,gpio_pull=up,debounce=1000" >> /boot/config.txt
  fi
  add_if_not_exists "dtparam=pwr_led_trigger=heartbeat" /boot/config.txt
  echo "dtoverlay=gpio-shutdown,gpio_pin=3,active_low=1,gpio_pull=up,debounce=1000 >> /boot/config.txt
}

# -------------------- UART --------------------
setup_hardware_uart(){
  add_if_not_exists "enable_uart=1" /boot/config.txt
  sed -i "s/console=serial0,115200 //g" /boot/cmdline.txt
  echo "********** Please execute below after reboot. ********************"
  echo "stty -F /dev/ttyS0 9600 cs8 -cstopb -parity"
  echo "******************************************************************"
}

# -------------------- USB --------------------
setup_usb_ether_gadget(){
  add_if_not_exists "dtoverlay=dwc2" /boot/config.txt
  if ! grep "modules-load=dwc2,g_ether" /boot/cmdline.txt > /dev/null 2>&1 ; then
    sed -i "s/rootwait/rootwait modules-load=dwc2,g_ether/g" /boot/cmdline.txt
  fi
}

# ==================== Git ====================
setup_git(){
  apt-get install -y git
  su - "${TARGET_USER}" << GITEOF
git config --global user.name "${GIT_USER}"
git config --global user.email "${GIT_MAIL}"
mkdir -p .ssh
echo "${GIT_SECRET_KEY}" > .ssh/git_secret_key
echo -n "
Host github.com
  HostName github.com
  User git
  Port 22
  IdentityFile ~/.ssh/git_secret_key
  IdentitiesOnly yes" > .ssh/config
chmod 600 .ssh/*
GITEOF
}

# ==================== Network ====================
# -------------------- Samba --------------------
setup_samba(){
  apt-get install -y samba expect

  useradd -m "${SMB_USER}"
  echo -e "${SMB_ACCESS_PASS}\n${SMB_ACCESS_PASS}" | smbpasswd -a "${SMB_USER}"
  expect -c "
  set timeout 10
  spawn smbpasswd -a $SMB_USER
    expect \"New SMB password:\"
      send \"$SMB_ACCESS_PASS\n\"
    expect \"Retype new SMB password:\"
      send \"$SMB_ACCESS_PASS\n\"
  interact
  "

  if ! grep "\[${SMB_USER}\]" /etc/samba/smb.conf > /dev/null 2>&1 ; then
    sed -i "/^\[global\]$/a \\    dos charset = CP932" /etc/samba/smb.conf
    sed -i "/^\[global\]$/a \\    unix charset = UTF8" /etc/samba/smb.conf
    sed -i "/^\[global\]$/a \\    min protocol = SMB2" /etc/samba/smb.conf
    sed -i "/^\[global\]$/a \\    max protocol = SMB2" /etc/samba/smb.conf
    sed -i "/^\[global\]$/a \\    veto files = /.*/" /etc/samba/smb.conf

    echo -n "[${SMB_USER}]
    comment = Samba Shared Folder
    path = ${SMB_DIR}
    guest ok = no
    read only = no
    browsable = yes
    writable = yes
    create mask = 0644
    directory mask = 0755" >> /etc/samba/smb.conf
  fi
}

# -------------------- Wi-Fi --------------------
setup_wifi(){
  echo -n "allow-hotplug wlan0
iface wlan0 inet manual
wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf" > /etc/network/interfaces.d/wlan0
}

add_wifi_network(){
  ssid="${1}"
  pass="${2}"
  conf="${3:-/etc/wpa_supplicant/wpa_supplicant.conf}"

  ret="$(wpa_passphrase "${ssid}" "${pass}" | grep -v "#")"
  psk="$(echo "${ret}" | grep -E ".*psk=.*")"

  # 既に存在するSSIDなら
  if grep "ssid=\"${ssid}\"" "${conf}" > /dev/null 2>&1 ; then
    # 前パスワード削除して新パスワード追加
    sed -i "/sid=\"${ssid}\"$/ {n;d}" "${conf}"
    sed -i "/ssid=\"${ssid}\"$/a \\${psk}" "${conf}"
  # 存在しないなら末尾に追加
  else
    echo "${ret}" >> "${conf}"
  fi
}

# -------------------- IPv6 disable --------------------
disable_ipv6(){
  switch_value net.ipv6.conf.all.disable_ipv6 /etc/sysctl.conf 0 1
  switch_value net.ipv6.conf.default.disable_ipv6 /etc/sysctl.conf 0 1
}

# ==================== SSH ====================
setup_ssh(){
  echo -n "
Port ${SSH_PORT}
PermitRootLogin ${SSH_ROOT_EN}
PasswordAuthentication ${SSH_PASS_EN}
PubkeyAuthentication ${SSH_PUBKEY_EN}
AuthorizedKeysFile .ssh/authorized_keys
" > "${SSH_CONF_PATH}"

  if [ "$SSH_PUBKEY_EN" = "yes" ]; then
      su - "${TARGET_USER}" << SSHEOF
mkdir -p .ssh
echo "${SSH_PUBKEY}" >> .ssh/authorized_keys
chmod 600 .ssh/*
SSHEOF
  fi
}

# ==================== Global ====================
# -------------------- Root Prompt Color --------------------
setup_root_prompt_color(){
  if ! grep "^PS1=" /root/.bashrc > /dev/null 2>&1 ; then
    echo -n "
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \$\[\033[00m\] '
" >> /root/.bashrc
  fi
}

# -------------------- Raspberry Pi Update --------------------
update(){
  apt-get update -y
  apt-get upgrade -y
  apt-get dist-upgrade -y
}


if [ "$(whoami)" != "root" ]; then
  echo "Permission Denied."
  exit 1
fi
set -x
# 不要なものはコメントアウトする
suppress_bluetooth_error
setup_heartbeat
#setup_hardware_uart
setup_usb_ether_gadget
#setup_git
#setup_samba
setup_wifi
#add_wifi_network LiteRaspberryPi 2023060915441588
disable_ipv6
#setup_ssh
setup_root_prompt_color
update
set +x

# 必ず再起動
reboot now
