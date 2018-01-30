# Ansible PalyBook


## 初期設定
  * apt upgrade
  * ユーザーの作成
  * apt upgrade
  * sshd
    * Port {{ sshd_port }}
    * Protocol 2
    * #HostKey /etc/ssh/ssh_host_dsa_key
    * PermitRootLogin no
    * RSAAuthentication yes
    * PubkeyAuthentication yes
    * PermitEmptyPasswords no
    * ChallengeResponseAuthentication no
    * PasswordAuthentication yes
    * GSSAPIAuthentication yes
    * GSSAPICleanupCredentials no
    * #AuthorizedKeysFile    .ssh/authorized_keys
  * ufw
    * ufw default deny incoming
    * ufw default allow outgoing
    + ufw allow 22022/tcp
  * TimeZone
  * ntpd
  * syslog
  * docker
