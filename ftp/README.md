# FTP

Install vsFTP

```bash
_ pacman -S vsftpd
```

Allow firewall access

```bash
_ firewall-cmd --add-service ftp --permanent
_ firewall-cmd --reload
```

Edit FTP config
`/etc/vsftpd.conf`

```bash
# Allow anonymous FTP? (Beware - allowed by default if you comment this out).
anonymous_enable=NO
#
# Uncomment this to allow local users to log in.
local_enable=YES
#
# Uncomment this to enable any form of FTP write command.
write_enable=YES
#
# Activate directory messages - messages given to remote users when they
# go into a certain directory.
dirmessage_enable=YES
#
# Activate logging of uploads/downloads.
xferlog_enable=YES
#
# Make sure PORT transfer connections originate from port 20 (ftp-data).
connect_from_port_20=YES
#
# When "listen" directive is enabled, vsftpd runs in standalone mode and
# listens on IPv4 sockets. This directive cannot be used in conjunction
# with the listen_ipv6 directive.
listen=YES
# Set own PAM service name to detect authentication settings specified
# for vsftpd by the system package.
pam_service_name=vsftpd

user_sub_token=$USER
local_root=/media/externalHdd/niflheim/ftp
```

Create certs

```bash
_ openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem
```

Add the following to `/etc/vsftpd.conf`

```bash
# Securing with SSL
rsa_cert_file=/etc/ssl/private/vsftpd.pem
rsa_private_key_file=/etc/ssl/private/vsftpd.pem
ssl_enable=YES
allow_anon_ssl=NO
force_local_data_ssl=YES
force_local_logins_ssl=YES
ssl_tlsv1=YES
ssl_sslv2=NO
ssl_sslv3=NO
require_ssl_reuse=NO
ssl_ciphers=HIGH
```
