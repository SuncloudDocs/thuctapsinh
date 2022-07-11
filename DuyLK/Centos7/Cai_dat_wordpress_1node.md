# Cài đặt Wordpress
## Menu
[1. Tắt firewall.](#TatFirewall)

[2. Cài đặt Apache.](#CaiDatApache)

[3. Cài đặt gói PHP.](#CaiDatPHP)

[4. Cài đặt CSDL.](#CaiDatCSDL)

[5. Cài đặt Wordpress](#CaiDatWordpress)

## Mô hình

![Wordpress1node](https://user-images.githubusercontent.com/84270045/155252881-22cb5ba5-6006-4abf-960f-f2a35fa3314c.png)



<a name="TatFirewall"></a>
### 1. Tắt firewall.
Sử dụng lệnh sau:
```
[root@server html]# systemctl disable firewalld --now
[root@server html]# setenforce 0
```

<a name="CaiDatApache"></a>
### 2. Cài đặt Apache.
Ta sử dụng lệnh:
```
yum install httpd -y
```

Sau khi apache được cài đặt thì ta khởi động apache và cho phép khởi động cùng hệ thống:
```
systemctl start httpd
systemctl enable httpd
```

Sử dụng lệnh `systemctl status httpd` để kiểm tra xem apache đã hoạt động hay chưa.

<a name="CaiDatPHP"></a>
### 3. Cài đặt gói `php`.
Để cài đặt kho Remi ta chạy lệnh sau.: `yum install -y yum-utils http://rpms.remirepo.net/enterprise/remi-release-7.rpm`

Sau khi cài đặt gói Remi xong, các bạn cần chọn phiên bản PHP mà mình cần cài đặt và kích hoạt gói chứa phiên bản PHP đó. Ở hướng dẫn này mình sẽ cài đặt PHP 8.0 nên sẽ kích hoạt gói bằng lệnh sau.: `yum-config-manager --enable remi-php80`

Sử dụng `yum` để cài php
```
yum install -y php-mysqlnd
yum install -y php php-common php-opcache php-mcrypt php-cli php-gd php-curl php-mysqlnd
```
Sau đó ta khởi động lại `httpd` bằng lệnh: `systemctl restart httpd`
 
Kiểm tra phiên bản `php` bằng lệnh: `php -v`

<a name="CaiDatCSDL"></a>
### 4. Cài đặt CSDL.
Cài đặt MariaDB Server:
```
yum -y install mariadb-server
```

Khởi động dịch vụ và cấu hình tường lửa:
```
systemctl start mariadb
```

```
systemctl enable mariadb
```

```
firewall-cmd --add-service=mysql --permanent
```

```
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

Truy cập MariaDB và tạo database, user:
- Truy cập MariaDB: 
```
mysql -u root -p
```

- Tạo database và user sử dụng cho wordpress:
```
create database wordpress;

create user 'wordpressuser'@'localhost' identified by 'password';


GRANT ALL PRIVILEGES ON wordpress.* TO wordpressuser@localhost;

FLUSH PRIVILEGES;
```

<a name="CaiDatWordpress"></a>
### 5. Cài đặt wordpress.
Truy cập vào thư mục `html`
```
cd /var/www/html/
```
  
Tiến hành download wordpress từ trên internet:
```
wget https://wordpress.org/latest.tar.gz
```

*Lưu ý: nếu chưa có `wget` ta tiến hành cài đặt bằng lệnh `yum install wget`*

Giải nén tệp vừa tải:
```
tar -xzvf latest.tar.gz
```

Cấu hình wordpress để kết nối với MySQL:
```
mv wordpress/* /var/www/html/
```

```
mv wp-config-sample.php wp-config.php
```

Tiến hành sửa file: 
```
vi wp-config.php
```

```
// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'wordpressuser' );

/** MySQL database password */
define( 'DB_PASSWORD', 'password' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );
```
Trong đó:

**DB_NAME**: tên Database được tạo ở trên.

**DB_USER**: tên User database được tạo ở trên.

**DB_PASSWORD**: mật khẩu đăng nhập của User.

**DB_HOST**: để localhost, địa chỉ của máy MySQL Server.

Sau đó thoát và lưu file.

Bây giờ mở trình duyệt và truy cập địa chỉ IP của máy bạn.

Ví dụ: 192.168.124.144/wp-admin

**CHÚC BẠN THÀNH CÔNG**
