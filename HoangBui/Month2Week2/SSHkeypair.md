# SSH Keypair
## 1. Tổng quan
SSH Keypair, còn được gọi là khóa SSH hoặc cặp khóa SSH, là một cặp khóa mật mã được sử dụng để liên lạc và xác thực an toàn trong giao thức SSH (Secure Shell). Giao thức SSH thường được sử dụng để kết nối và quản lý an toàn các máy chủ và thiết bị từ xa.

Cặp khóa bao gồm hai phần: khóa chung và khóa riêng. Khóa riêng được giữ bí mật và không bao giờ được chia sẻ với người khác, trong khi khóa chung có thể được phân phối miễn phí cho các máy chủ hoặc thiết bị từ xa mà bạn muốn xác thực.

Khi bạn cố gắng kết nối với một máy chủ từ xa bằng SSH, máy chủ sẽ kiểm tra xem khóa công khai của bạn có trong danh sách các khóa được ủy quyền hay không. Nếu tìm thấy khớp, máy chủ sẽ yêu cầu bạn chứng minh rằng bạn sở hữu khóa riêng tư tương ứng. Quá trình xác thực này giúp đảm bảo rằng chỉ những người dùng được ủy quyền mới có thể truy cập vào máy chủ.

Tạo một cặp khóa SSH thường liên quan đến việc sử dụng các công cụ như ssh-keygen trên các hệ thống dựa trên Unix hoặc PuTTYgen trên Windows. Các công cụ này tạo các tệp khóa công khai và riêng tư, thường được đặt tên là id_rsa.pub (khóa chung) và id_rsa (khóa riêng tư) theo mặc định.
## 2. Tạo một SSH key pair
- Để tạo một cặp khoá SSH, có thể sử dụng công cụ `ssh-keygen`, công cụ sẽ yêu cầu bạn nhập tên khoá, cụm mật khẩu cho khoá. Sau đó, khoá sẽ được lưu vào tệp mặc định của hệ thống `/home/username`.
- Lệnh dưới đây sẽ tạo ra một cặp khoá RSA (`-t rsa`) với độ dài khoá là 4096 bit (`-b 4096`).
```bash
~$ ssh-keygen -t rsa -b 4096
Generating public/private rsa key pair.
Enter file in which to save the key (/home/hoangbuii/.ssh/id_rsa): sshkey.pem
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in sshkey.pem
Your public key has been saved in sshkey.pem.pub
The key fingerprint is:
SHA256:DUuvCsm2j7m82oX2PTUC30j/NkkUUgcXwQsx9h41So4 hoangbuii@Ubuntu
The key's randomart image is:
+---[RSA 4096]----+
|           .*==+.|
|          ..*=o..|
|        o  E =o. |
|      ...=  .... |
|       +S+o.  .  |
|   . o  +.= .    |
|    B . .o + .   |
|   = B o.   =    |
|  ..O++ .. . .   |
+----[SHA256]-----+
```
- Sau khi tạo SSH Keypair, sẽ có hai khoá được tạo ra là khoá riêng tư và khoá công khai (`.pub`)
## 3. Kết nối với SSH server sử dụng khoá SSH
- Để thiết lập xác thực, hãy sao chép khoá công khai vào thư mục `/etc/ssh`
```bash
sudo scp /home/hoangbuii/sshkey.pem.pub /etc/ssh
```
- Để kết nối với SSH server, bạn cần có khoá riêng tư của cặp khoá SSH, sử dụng lệnh sau để kết nối với SSH Server:
```bash
ssh -i <private_key> username@hostname
```
Ví dụ:
```bash
> ssh -i "sshkey.pem" hoangbuii@192.168.68.159
hoangbuii@192.168.68.159's password:
Welcome to Ubuntu 22.04.2 LTS (GNU/Linux 5.19.0-43-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

Expanded Security Maintenance for Applications is not enabled.

49 updates can be applied immediately.
To see these additional updates run: apt list --upgradable

2 additional security updates can be applied with ESM Apps.
Learn more about enabling ESM Apps service at https://ubuntu.com/esm

Last login: Thu Jun 15 15:31:11 2023 from 192.168.68.148
hoangbuii@Ubuntu:~$
```