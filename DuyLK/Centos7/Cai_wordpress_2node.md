# Cài wordpress 2 node
## Menu
[Cài đặt Database](#Database)
- [Cài đặt MariaDB](#CaiDatMariaDB)

[Cài đặt Web Server](#CaiDatWebserver)
- [Cài đặt Apache](#CaiDatApache)
- [Cài đặt PHP](#CaiDatPHP)
- [Cài đặt Wordpress](#CaiDatWordpress)






<a name="Database"></a>
## Cài đặt Database
Lưu ý: **Địa chỉ IP của máy cài Database là `192.168.73.128`**
<a name="CaiDatMariaDB"></a>
#### Cài đặt MariaDB
Ta sử dụng lệnh: `yum -y install mariadb-server`

Khởi động dịch vụ và cấu hình tường lửa:
```
systemctl start mariadb
systemctl enable mariadb
firewall-cmd --add-service=mysql --permanent
firewall-cmd --reload
```

Thiết lập bảo mật cho MariaDB: sử dụng lệnh `mysql_secure_installation` và làm như sau:
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

Xem phiên bản MariaDB: `mysql -v`

Truy cập vào MariaDB: `mysql -u root -p` ( nhập mật khẩu đã đặt ở phần thiết lập bảo mật ở trên )

Tạo database và user sử dụng cho wordpress:
```
create database wordpress;

create user 'wordpressuser'@'192.168.73.129' identified by 'password';


GRANT ALL PRIVILEGES ON wordpress.* TO wordpressuser@192.168.73.129;

FLUSH PRIVILEGES;
```

**Lưu ý**: `192.168.73.129` : là địa chỉ của của máy Web truy cập MySQL

Sau đó ta dùng lệnh `exit` để thoát khỏi MariaDB.

Cấu hình tường lửa cho dịch vụ MariaDB: 
```
firewall-cmd --add-service=mysql --permanent
firewall-cmd --reload
```

<a name="CaiDatWebserver"></a>
## Cài đặt Web Server
Lưu ý: **Địa chỉ IP của máy cài Web Server là `192.168.73.129`**

<a name="CaiDatApache"></a>
#### 1. Cài đặt Apache
Ta sử dụng lệnh: `yum install httpd -y` 

khởi động dịch vụ Apache và cho phép nó khởi động cùng hệ thống:
```
systemctl start httpd
systemctl enable httpd
```

Xem phiên bản dịch vụ apache: `httpd -v`

Cấu hình tường lửa cho dịch vụ apache:
```
firewall-cmd --add-service=http --permanent
firewall-cmd --add-service=https --permanent
firewall-cmd --reload
```

<a name="CaiDatPHP"></a>
#### 2. Cài đặt PHP
Để cài đặt kho Remi ta chạy lệnh sau.: `yum install -y yum-utils http://rpms.remirepo.net/enterprise/remi-release-7.rpm`

Sau khi cài đặt gói Remi xong, các bạn cần chọn phiên bản PHP mà mình cần cài đặt và kích hoạt gói chứa phiên bản PHP đó. Ở hướng dẫn này mình sẽ cài đặt PHP 8.0 nên sẽ kích hoạt gói bằng lệnh sau.: `yum-config-manager --enable remi-php80`

```
yum install -y php-mysqlnd
yum install -y php php-common php-opcache php-mcrypt php-cli php-gd php-curl php-mysqlnd
```
Xem phiên bản PHP: `php -v`

<a name="CaiDatWordpress"></a>
#### 3. Cài đặt Worpress
Truy cập vào thư mục `html`: `cd /var/www/html/`

Tiến hành download wordpress từ trên internet: `wget https://wordpress.org/latest.tar.gz`

*Lưu ý: nếu chưa có wget ta tiến hành cài đặt bằng lệnh `yum install wget`*

Giải nén tệp vừa tải: `tar -xzvf latest.tar.gz`

Cấu hình wordpress để kết nối với MySQL: 
```
mv wordpress/* /var/www/html/
mv wp-config-sample.php wp-config.php
```

Tiến hành sửa file: `vi wp-config.php`

![sua_file_wpconfig](https://user-images.githubusercontent.com/84270045/155456032-9324509b-2326-4b98-9bf6-2548ff1c66ca.png)

**Lưu ý** : `192.168.73.128` là địa chỉ ip localhost của sql .
Kiểm tra xem đã cài đặt thành công hay chưa: `http://192.168.73.129/wordpress/`


