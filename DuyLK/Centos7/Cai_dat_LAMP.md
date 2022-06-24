# Cài đặt LAMP
## Menu
[1, Tắt firewall](#TatFirewall)

[2, Cài đặt Apache](#CaiDatApache)

[3, Cài đặt MariaDB](#CaiDatMariaDB)

[4, Cài đặt PHP](#CaiDatPHP)

[5, Cấu hình Virtual host](#CauHinhVirtualHost)

[6, Kiểm tra hoạt động của Website](#KiemTraHoatDongWevsite)




**Khái niệm LAMP**: `LAMP` là chữ viết tắt thường được dùng để chỉ sự sử dụng các phần mềm `Linux`, `Apache`, `MySQL`, và ngôn ngữ văn lệnh `PHP` hay `Python` để tạo nên một môi trường máy chủ Web có khả năng chứa và phân phối các trang Web động.
<a name="TatFirewall"></a>
### 1, Tắt firewall
Ta sử dụng lệnh:
``` 
systemctl disable firewalld --now
setenforce 0
```

<a name="CaiDatApache"></a>
### 2, Cài đặt Apache
Ta sử dụng lệnh: `yum install httpd -y`

Sau khi apache được cài đặt thì ta khởi động apache và cho phép khởi động cùng hệ thống:
```
systemctl start httpd
systemctl enable httpd
```

Nếu các bạn sử dụng Firewalld để có thể truy cập được website các bạn sẽ cần mở port bằng các lệnh sau đây:
```
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload
```

Sử dụng lệnh `systemctl status httpd` để kiểm tra xem apache đã hoạt động hay chưa.

<a name="CaiDatMariaDB"></a>
### 3, Cài đặt MariaDB
Để cài đặt MariaDB ta sử dụng lệnh:
```
yum install -y mariadb mariadb-server
```

Khởi động dịch vụ: 
```
systemctl start mariadb
systemctl enable mariadb
```

Thiết lập MariaDB: `mysql_secure_installation`
```
Enter current password for root (enter for none): Nhấn phím Enter
Switch to unix_socket authentication [Y/n]: n
Change the root password? [Y/n]: Y
New password: Nhập password root các bạn muốn tạo
Re-enter new password: Nhập lại password root
Remove anonymous users? [Y/n] : Y
Disallow root login remotely? [Y/n]: Y
Remove test database and access to it? [Y/n] : Y
Reload privilege tables now? [Y/n]: Y
```

<a name="CaiDatPHP"></a>
### 4, Cài đặt PHP
Để cài đặt kho remi ta dùng lệnh sau: `yum install -y yum-utils http://rpms.remirepo.net/enterprise/remi-release-7.rpm`

Sau khi cài đặt gói Remi xong, ta cần chọn phiên bản PHP mà mình cần cài đặt và kích hoạt gói chứa phiên bản PHP đó. Ở đây ta sẽ cài đặt `PHP 8.0` nên sẽ kích hoạt gói bằng lệnh sau: `yum-config-manager --enable remi-php80`

*Lưu ý: Ở số `80` (tương ứng `PHP 8.0`), bạn có thể thay thế bằng phiên bản PHP bạn muốn (Ví dụ: 72 – 73 –74 tương ứng 7.2 –7.3 – 7.4..)*

Khi module remi-80 của PHP đã được bật, bạn có thể tiến hành cài đặt PHP và các PHP Extension cần thiết bằng lệnh bên dưới: `yum install -y php php-ldap php-zip php-embedded php-cli php-mysql php-common php-gd php-xml php-mbstring php-mcrypt php-pdo php-soap php-json php-simplexml php-process php-curl php-bcmath php-snmp php-pspell php-gmp php-intl php-imap perl-LWP-Protocol-https php-pear-Net-SMTP php-enchant php-pear php-devel php-zlib php-xmlrpc php-tidy php-opcache php-cli php-pecl-zip unzip gcc`

Kiểm tra phiên bản PHP vừa cài đặt bằng cách dùng lệnh: `php -v`

<a name="CauHinhVirtualHost"></a>
### 5, Cấu hình Virtual host
Virtual Host là file cấu hình trong Apache để cho phép nhiều Domain cùng chạy trên một máy chủ. Tất cả các file vhost sẽ nằm trong thư mục tại đường dẫn  `/etc/httpd/conf.d/`. Để dễ dàng quản lý thì mỗi Website nên có một vhost riêng, ví dụ: `azdigi.cf.conf`

Ở bài hướng dẫn này, mình sẽ tạo website là `azdigi.cf` và vhost của nó tương ứng sẽ là `/etc/httpd/conf.d/azdigi.cf.conf`

- Tạo file: `touch /etc/httpd/conf.d/azdigi.cf.conf`

- Chỉnh sửa file: `vi /etc/httpd/conf.d/azdigi.cf.conf`

Sau khi mở file `azdigi.cf.conf` lên, các bạn copy nội dung bên dưới và dán vào file `azdigi.cf.conf` => Save lại.
```
<VirtualHost *:80>
        ServerName azdigi.cf
        ServerAlias www.azdigi.cf
        DocumentRoot /var/www/azdigi.cf/html
        ErrorLog /var/log/httpd/azdigi.cf_error.log
        CustomLog /var/log/httpd/azdigi.cf_access.log combined
</VirtualHost>
```

Tiếp theo ta cần tạo thư mục chứa mã nguồn website bằng lệnh sau:
- Tạo folder azdigi.cf và html chứa dữ liệu website: `mkdir -p /var/www/azdigi.cf/html`
- Phân quyền thực thi cho thư mục: `chown -R apache:apache /var/www/azdigi.cf`

Bây giờ ta khởi động lại dịch vụ Apache bằng lệnh: `systemctl restart httpd`

<a name="KiemTraHoatDongWevsite"></a>
### 6, Kiểm tra hoạt động website
Sau khi đã cấu hình hoàn tất Virtual Host và tạo folder website hoàn tất, các bạn kiểm tra nhanh xem website của mình có hoạt động hay không bằng cách tạo thử file `index` bằng lệnh sau: `touch /var/www/azdigi.cf/html/index.html | echo "Cai dat thanh cong LAMP" > /var/www/azdigi.cf/html/index.html`


