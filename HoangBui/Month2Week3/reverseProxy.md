# Reverse Proxy Usecase
## 1. Truy cập nhiều host từ một proxy server
-  Topology:
    - Tại proxy server có chứa hai thư mục web là `example1.com` và `example2.com`.
    - Từ Client cần truy cập 2 thư mục trên thông qua 2 tên miền là *example1.com* và *example2.com*
![noimg](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week3/nginximg/topouse1.png)
- Các file tại `/var/www/html` có dạng như sau:
```bash
.
├── example1.com
│   └── index.html
└── example2.com
    └── index.html
```
- File `index.html` tại `example1.com/` (`example2.com/` tương tự)
```html
<!DOCTYPE html>
<html>
<head>
  <title>HTML page from proxy server</title>
</head>
<body>
  <h1>Welcome Web page form <b>example1</b> on <i>192.168.68.170</i></h1>

  <p>This is infomation of system.</p>

  <ul>
    <li>Ubuntu</li>
    <li>NGinX</li>
    <li>Virtualization using VMware</li>
  </ul>

</body>
</html>
```
- Cấu hình NGinX: Truy cập file `/etc/nginx/nginx.conf` và thêm 2 khối server sau:
```conf
server {
    listen 80;
    server_name example1.com;
    location / {
        root /var/www/html/example1.com;
        index index.html;

    }
}
server {
    listen 80;
    server_name example2.com;
    location / {
        root /var/www/html/example2.com;
        index index.html;

    }
}
```
- Khởi động lại NGinX:
```bash
sudo service nginx reload
```
- Kiểm tra kết quả: 
    - Khi truy cập tên miền *example1.com* tại client sẽ truy cập đến host tại `/var/www/html/example1.com`
    - Khi truy cập tên miền *example2.com* tại client sẽ truy cập đến host tại `/var/www/html/example2.com`
    ![noimg](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week3/nginximg/webonpro1.png)
    ![noimg](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week3/nginximg/webonpro2.png)
## 2. Từ một Proxy server, chuyển tiếp kết nối thông qua 2 Backend Server khác dựa vào tên miền.
- Topology:
    - Proxy server cài đặt Ubuntu và chạy NGinX
    - Hai backend Server chạy CentOS và chạy Apache
    - Từ Client truy cập đến proxy server sẽ chuyển tiếp liên kết đến hai backend server dựa vào tên miền
![noimg](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week3/nginximg/topouse2.png)
- File `index.html` tại *example1.com*(tại *example2.com* tương tự):
```html
<!DOCTYPE html>
<html>
<head>
  <title>HTML page from backend server</title>
</head>
<body>
  <h1>Welcome Web page form <b>example1</b> on <i>192.168.68.214</i></h1>

  <p>This is infomation of system.</p>

  <ul>
    <li>CentOS</li>
    <li>Apache</li>
    <li>Virtualization using VMware</li>
  </ul>

</body>
</html>
```
- Cấu hình NGinX: Truy cập file `/etc/nginx/nginx.conf` và thêm 2 khối server sau:
```conf
server {
    listen 80;
    server_name example1.com;
    location / {
        proxy_pass http://192.168.68.214;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;

    }
}
server {
    listen 80;
    server_name example2.com;
    location / {
        proxy_pass http://192.168.68.232;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}

```
- Khởi động lại NGinX:
```bash
sudo service nginx reload
```
- Kiểm tra kết quả: 
    - Khi truy cập tên miền *example1.com* tại client sẽ chuyển tiếp đến máy chủ `example1.com`
    - Khi truy cập tên miền *example2.com* tại client sẽ chuyển tiếp đến máy chủ `example1.com`

    ![noimg](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week3/nginximg/webonback1.png)
    ![noimg](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week3/nginximg/webonback2.png)

## 3. Từ một reverse proxy server, cấu hình HA đến các server backend, các server backend dùng chung một database server
- HA:
HA (High Availability) đề cập đến một hệ thống hoặc thiết lập được thiết kế để giảm thiểu hoặc loại bỏ thời gian ngừng hoạt động và đảm bảo hoạt động liên tục. HA thường bao gồm những thành phần chính sau:
    - Phần cứng dự phòng
    - Cơ chế chuyển đổi dự phòng
    - Cân bằng tải
    - Khôi phục tự động
- Topology:
    - Client truy cập vào web dựa trên tên miền `example1.com`
    - Reverse proxy server sẽ chuyển hướng các kết nối từ client đến 2 backend server đồng thời thiết lập HA giữa chúng
    - Hai backend server sử dụng chung một database server được cài đặt trên MariaDB

![noimg](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week3/nginximg/topouse3.png)
- Cài đặt MySQL(hoặc Mariadb) trên CentOS:
    - Cài đặt MariaDB:
    ```bash
    sudo yum install mariadb-server
    ```
    - Cài đặt bảo mật cho MySQL(Sử dụng lệnh sau và làm theo các bước ở dưới):
    ```bash
    sudo mysql_secure_installation
    ```
    - Tạo database cho wordpress
    ```sql
    CREATE DATABASE wordpress;
    CREATE USER 'user'@'web_server_IP' IDENTIFIED BY 'password';
    GRANT ALL PRIVILEGES ON wordpress.* TO 'user'@'localhost';
    FLUSH PRIVILEGES;
    EXIT;
    ```
    Thay thế `web_server_ip` bằng địa chỉ IP của web server (Nếu có nhiều web server chung một dải ip có thể gán chung bằng kí hiệu `%` VD: `192.168.68.%`)
    - Cấu hình filewall để truy cập từ web server:
    ```bash
    sudo firewall-cmd --add-port=3306/tcp 
    sudo firewall-cmd --permanent --add-port=3306/tcp
    ```
    - Hoặc tắt firewall
    ```bash
    sudo systemctl stop firewalld
    ```
- Cài đặt, cấu hình web server:
    - Cài đặt Apache trên CentOS
        - Cài đặt Apache
        ```bash
        sudo yum install httpd
        ```
        - Khởi chạy Apache
        ```bash
        sudo systemctl start httpd
        sudo systemctl enable httpd
        ```
        - Cấu hình firewall cho phép truy cập:
        ```bash
        sudo firewall-cmd --permanent --add-service=http
        sudo firewall-cmd --reload
        ```
    - Cài đặt PHP 8.1 trên CentOS:
        - Cài đặt những package cần thiết:
        ```bash
        sudo yum install epel-release yum-utils
        ```
        - Cài Remi RPM repository:
        ```bash
        sudo yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
        ```
        - Sau đó, cho phép cài đặt PHP8.1
        ```bash
        sudo yum-config-manager --enable remi-php81
        ```
        - Cài đặt PHP:
        ```bash
        sudo yum install php
        ```
        - Kiểm tra phiên bản PHP
        ```bash
        php -v
        ```
        - Cài đặt các module khác của php
        ```bash
        sudo yum install php-mysql php-gd php-xml php-mbstring
        ```
        - Restart lại Apache để áp dụng các package trên
        ```bash
        sudo systemctl restart httpd
        ```
    - Cài đặt wordpress trên CentOS:
        - Cài đặt MariaDB Client:
        ```bash
        sudo yum install mariadb
        ```
        - Tải xuống và cài đặt Wordpress:
        ```bash
        mkdir tmp
        sudo yum install wget
        cd /tmp
        wget https://wordpress.org/latest.tar.gz
        tar -xf latest.tar.gz
        sudo mv wordpress /var/www/html/
        sudo chown -R apache:apache /var/www/html/wordpress/
        sudo chmod -R 755 /var/www/html/wordpress/
        sudo cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
        ```
        - Cấu hình file cài đặt wordpress
        ```bash
        sudo nano /var/www/html/wordpress/wp-config.php
        ```
        - Tại file `wp-config.php` cấu hình file để kết nối với database server
        ```php
        define('DB_NAME', 'wordpress');
        define('DB_USER', 'user');
        define('DB_PASSWORD', 'password');
        define('DB_HOST', 'database_server_ip');
        ```
        Thay thế `database_server_ip` bằng địa chỉ IP của database server.
    - Cấu hình Apache:
        - Truy cập file cấu hình Apache:
        ```bash
        sudo nano /etc/httpd/conf/httpd.conf
        ```
        - Sửa đổi `DocumentRoot` và thẻ `<Directory>` để trỏ đến thư mục của Wordpress:
        ```conf
        DocumentRoot "/var/www/html/wordpress"

        <Directory "/var/www/html/wordpress">
            AllowOverride None

            # Allow open access:
            Require all granted
        </Directory>
        ```
        - Vô hiệu hoá SELinux
        ```bash
        sudo nano /etc/sysconfig/selinux
        ```
        - Tìm đến dòng `SELINUX=enforcing` và chỉnh thành `SELINUX=disabled`. Sau đó dùng lệnh `reboot` để khởi động lại hệ thống.
        - Khởi động lại Apache
        ```bash
        sudo systemctl restart httpd
        ```
    - Truy cập vào địa chỉ IP của web server và cài đặt Wordpress(xem thêm tại: [Wordpres Installation](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week3/Wordpress.md))
    - Làm tương tự với Web server còn lại.
- Cấu hình Reverse proxy server:
    - Truy cập file cấu hình của NGinX
    ```bash
    sudo nano /etc/nginx/nginx.conf
    ```
    - Thêm khối các backend server(xem thêm các thuật toán tại [Explain NGinX](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week3/NGinX.md)):
    ```conf
    upstream backend {
        server 192.168.68.214;
        server 192.168.68.232;
    }
    ```
    - Sửa khối server để chuyển hướng và cân bằng tải đến các backend server:
    ```conf
    server {
        listen 80;
        server_name example1.com;

        location / {
            proxy_pass http://backend;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        }
    }
    ```
- Sau khi cấu hình các thành phần trên, ta có thể truy cập đến các backend server thông qua proxy server bằng trình duyệt của client(Nếu một trong 2 backend server bị ngắt kết nối reverse proxy servẻ sẽ chuyển toàn bộ tải cho backend server còn lại)

![noimg](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week3/nginximg/clientacc.png)