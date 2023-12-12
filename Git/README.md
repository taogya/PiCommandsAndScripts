# Git
- [インストール](#install)
- [接続設定](#connection)

## <a id="install">インストール</a>
```sh
apt-get install -y git
```

## <a id="connection">接続設定</a>
GitHubにアクセスしたいユーザーで実行<br>
```sh
GIT_USER=
GIT_MAIL=
GIT_SECRET_KEY=

git config --global user.name "${GIT_USER}"
git config --global user.email "${GIT_MAIL}"
mkdir -p ~/.ssh
echo "${GIT_SECRET_KEY}" > ~/.ssh/git_secret_key
echo -n "
Host github.com
    HostName github.com
    User git
    Port 22
    IdentityFile ~/.ssh/git_secret_key
    IdentitiesOnly yes" >> ~/.ssh/config
chmod 600 ~/.ssh/*
ssh -T git@github.com

# GIT_SECRET_KEYの環境変数設定履歴を消すため
history -c
```
