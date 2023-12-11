# サーバーの設定
```sh
# root権限
sudo su -
apt-get install -y git
exit
```
```sh
# user権限
GIT_USER=
GIT_MAIL=
GIT_SECRET_KEY_NAME=
GIT_SECRET_KEY=

git config --global user.name "${GIT_USER}"
git config --global user.email "${GIT_MAIL}"
mkdir -p ~/.ssh
echo "${GIT_SECRET_KEY}" > ~/.ssh/"${GIT_SECRET_KEY_NAME}"
echo -n "Host github.com
    HostName github.com
    User git
    Port 22
    IdentityFile ~/.ssh/${GIT_SECRET_KEY_NAME}
    IdentitiesOnly yes" > ~/.ssh/config
chmod 600 ~/.ssh/*

ssh -vT git@github.com

history -c
```
