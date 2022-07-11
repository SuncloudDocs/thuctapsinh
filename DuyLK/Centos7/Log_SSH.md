# Menu
[I. Trong Centos](#Centos)
- [1. Log SSH](#Log_SSH)
- [2. Log ghi lại những lần đăng nhập thành công](#Log_thanh_cong)
- [3. Log lại những lần đăng nhập thất bại](#Log_that_bai)

[II. Trong Ubuntu](#Ubuntu)

[Tài liệu tham khảo](#Tai_lieu_tham_khao)






<a name="Centos"></a>

## I. Trong Centos
Trong CentOS hoặc RHEL , các phiên SSH không thành công được ghi lại trong tệp `/var/log/secure` . Đưa ra lệnh trên đối với tệp nhật ký này để xác định thông tin đăng nhập SSH không thành công.
```
[root@centos ~]# egrep "Failed|Failure" /var/log/secure
Jun  3 20:33:46 localhost sshd[15677]: Failed password for root from 192.168.20.142 port 58942 ssh2
[root@centos ~]#
```
Hoặc có thể sử dụng lênh `grep "Failed" /var/log/secure`.
Một số log thường gặp.

<a name="Log_SSH"></a>

### 1. Log SSH: `/var/log/secure`
```
[root@vqmanh ~]# tailf /var/log/secure | grep ssh 
Login thành công
Sep 17 08:04:29 vqmanh sshd[10709]: Accepted password for vqmanh from 66.0.0.254 port 58710 ssh2
---------------
Login thất bại
Sep 17 08:33:21 vqmanh sshd[11262]: Failed password for pak from 66.0.0.254 port 58954 ssh2
-----------------------
Login sai user
Sep 17 10:40:37 vqm sshd[10668]: Invalid user vqmanh from 66.0.0.254 port 60347
```

<a name="Log_thanh_cong"></a>

### 2. Log ghi lại những lần đăng nhập thành công
```
[root@laiduy log]# last -f /var/log/wtmp
root     pts/0        192.168.20.1     Fri Jun 10 08:30   still logged in
root     tty1                          Fri Jun 10 08:30   still logged in
reboot   system boot  3.10.0-1160.el7. Fri Jun 10 08:24 - 09:27  (01:02)
root     pts/1        192.168.20.1     Thu Jun  9 10:54 - 19:06  (08:12)
root     pts/0        192.168.20.1     Thu Jun  9 08:24 - 12:35  (04:11)
root     tty1                          Thu Jun  9 08:24 - crash (1+00:00)
reboot   system boot  3.10.0-1160.el7. Thu Jun  9 08:23 - 09:27 (1+01:04)
root     pts/0        192.168.20.1     Mon Jun  6 08:30 - crash (2+23:52)
root     tty1                          Mon Jun  6 08:29 - crash (2+23:54)
reboot   system boot  3.10.0-1160.el7. Mon Jun  6 08:28 - 09:27 (4+00:59)
root     pts/0        192.168.20.1     Thu May 19 16:02 - crash (17+16:25)
root     pts/0        192.168.20.1     Thu May 19 16:00 - 16:02  (00:01)
root     pts/0        192.168.20.1     Thu May 19 15:59 - 16:00  (00:00)
root     pts/0        192.168.20.1     Thu May 19 15:54 - 15:59  (00:04)
root     pts/0        192.168.20.1     Thu May 19 14:24 - 15:54  (01:30)
root     pts/1        192.168.20.1     Thu May 19 13:21 - 15:54  (02:32)
root     pts/0        192.168.20.1     Thu May 19 10:29 - 14:06  (03:36)
root     pts/0        192.168.20.1     Thu May 19 10:26 - 10:28  (00:02)
root     pts/0        192.168.20.1     Thu May 19 10:17 - 10:25  (00:08)
root     tty1                          Thu May 19 10:16 - crash (17+22:11)
reboot   system boot  3.10.0-1160.el7. Thu May 19 10:16 - 09:27 (21+23:11)
root     pts/0        gateway          Thu May 12 09:34 - crash (7+00:41)
root     tty1                          Thu May 12 09:31 - crash (7+00:44)
reboot   system boot  3.10.0-1160.el7. Thu May 12 09:30 - 09:27 (28+23:56)
root     pts/0        192.168.73.1     Thu Feb 24 00:08 - 00:09  (00:00)
root     tty1                          Thu Feb 24 00:06 - 00:14  (00:08)
reboot   system boot  3.10.0-1160.el7. Thu Feb 24 00:05 - 00:14  (00:09)

wtmp begins Thu Feb 24 00:05:08 2022
[root@laiduy log]#
```

<a name="Log_that_bai"></a>

### 3. Log lại những lần đăng nhập thất bại
```
[root@laiduy log]# lastb -f /var/log/btmp | more
root     tty1                          Thu Jun  9 08:23 - 08:23  (00:00)

btmp begins Thu Jun  9 08:23:59 2022
[root@laiduy log]#
```

<a name="Ubuntu"></a>

## II. Trong Ubuntu
```
laiduy@laikhanhduy:~$ sudo cat /var/log/auth.log
[sudo] password for laiduy:
Jun 10 01:48:27 laikhanhduy login[923]: pam_unix(login:auth): authentication failure; logname=LOGIN uid=0 euid=0 tty=/dev/tty1 ruser= rhost=  user=laiduy
Jun 10 01:48:31 laikhanhduy login[923]: FAILED LOGIN (1) on '/dev/tty1' FOR 'laiduy', Authentication failure
Jun 10 01:48:41 laikhanhduy login[923]: FAILED LOGIN (2) on '/dev/tty1' FOR 'laiduy', Authentication failure
Jun 10 01:48:51 laikhanhduy login[923]: FAILED LOGIN (3) on '/dev/tty1' FOR 'laiduy', Authentication failure
Jun 10 01:49:01 laikhanhduy login[923]: pam_unix(login:auth): check pass; user unknown
Jun 10 01:49:01 laikhanhduy login[923]: pam_unix(login:auth): authentication failure; logname=LOGIN uid=0 euid=0 tty=/dev/tty1 ruser= rhost=
Jun 10 01:49:04 laikhanhduy login[923]: FAILED LOGIN (4) on '/dev/tty1' FOR 'UNKNOWN', Authentication failure
Jun 10 01:49:12 laikhanhduy login[923]: FAILED LOGIN (5) on '/dev/tty1' FOR 'laiduy', Authentication failure
Jun 10 01:49:12 laikhanhduy login[923]: TOO MANY LOGIN TRIES (5) on '/dev/tty1' FOR 'laiduy'
Jun 10 01:49:12 laikhanhduy login[923]: pam_mail(login:session): pam_putenv: delete non-existent entry; MAIL
Jun 10 01:49:12 laikhanhduy login[923]: pam_unix(login:session): session closed for user laiduy
Jun 10 01:49:12 laikhanhduy login[923]: PAM 3 more authentication failures; logname=LOGIN uid=0 euid=0 tty=/dev/tty1 ruser= rhost=  user=laiduy
Jun 10 01:49:12 laikhanhduy login[923]: PAM service(login) ignoring max retries; 4 > 3
Jun 10 01:50:05 laikhanhduy login[1207]: pam_unix(login:auth): check pass; user unknown
Jun 10 01:50:05 laikhanhduy login[1207]: pam_unix(login:auth): authentication failure; logname=LOGIN uid=0 euid=0 tty=/dev/tty1 ruser= rhost=
Jun 10 01:50:08 laikhanhduy login[1207]: FAILED LOGIN (1) on '/dev/tty1' FOR 'UNKNOWN', Authentication failure
Jun 10 01:50:20 laikhanhduy login[1207]: pam_unix(login:session): session opened for user laiduy by LOGIN(uid=0)
Jun 10 01:50:20 laikhanhduy systemd-logind[903]: New session 1 of user laiduy.
Jun 10 01:50:21 laikhanhduy systemd: pam_unix(systemd-user:session): session opened for user laiduy by (uid=0)
Jun 10 01:51:11 laikhanhduy sshd[1421]: Accepted password for laiduy from 192.168.20.1 port 61483 ssh2
Jun 10 01:51:11 laikhanhduy sshd[1421]: pam_unix(sshd:session): session opened for user laiduy by (uid=0)
...
laiduy@laikhanhduy:~$
```

<a name="Tai_lieu_tham_khao"></a>

## Tài liệu tham khảo
[Log SSH](https://news.cloud365.vn/log-ly-thuyet-tong-quan-ve-log-syslog-rsyslog/)(Tiếng Việt)

[Log SSH](https://linuxhint.com/check_sshd_logs_linux/)(Tiếng Anh)




















































