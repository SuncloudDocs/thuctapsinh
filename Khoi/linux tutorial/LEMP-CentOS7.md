##cài đặt LEMP trên centOS7
LEMP là một nhóm các phần mềm có thể phục vụ các trang web động và các ứng dụng web.

- Linux: Là hệ điều hành, cũng là phần mềm dùng để điều phối và quản lý các tài nguyên của hệ thống.
- (E)nginx: Là phần mềm máy chủ web, có thể thực hiện các request(Yêu cầu) được gọi tới máy chủ thông qua các giao thức HTTP.
- MySQL & MariaDB: Là hệ quản trị cở sở dữ liệu giúp lưu trữ và truy xuất dữ liệu.
- PHP: là ngôn ngữ lập trình cho kịch bản hoạt động của máy chủ.

##chuẩn bị 
- Máy được cài sẵn hệ điều hành centOS7
- Có quyền kết nối ra môi trường internet
- Lệnh được dùng với quyền cao nhất
- 
##Cài đặt Nginx 
`yum -y update`
`yum install -y epel-release` 

`yum install nginx -y`
`systemctl start nginx`

- Nếu bạn đang chạy tường lửa thì , cần phải tắt tường lửa ,
có thể sử dụng tắt luôn hoặc chạy lệnh sau 
`firewall-cmd --permanent --zone=public --add-service=http`
`firewall-cmd --permanent --zone=public --add-service=https`
`firewall-cmd --reload`

- Lệnh dừng tường lửa 
`systemctl stop firewalld`

- Sau đó vào trang web, ở url nhập địa chỉ IP của máy đang chạy
  
  ![Imgur](https://i.imgur.com/dg8Si9o.png)

- Cài đặt thành công Nginx
- Để cho phép Nginx khởi động cùng server 
`systemctl enable nginx`

##Cài đặt MySQL/Mariadb 
- Tiến hành cài đặt mariadb
`yum -y install mariadb mariadb-server`

- Sau khi cài đặt xong tiến hành khởi động 
`systemctl start mariadb`
- Tiến hành cài đặt mật khẩu root 
`mysql_secure_installation`

- Tiến hành một số bước như sau 
![Imgur](https://i.imgur.com/YIkZkjO.png)

![Imgur](https://i.imgur.com/Rt7Bp6H.png)

##Cài đặt PHP

`yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm`
 
 - Sau khi cài đặt xong cần chạy một số lệnh dưới để kích hoạt kho lưu trữ của php

`yum --disablerepo="*" --enablerepo="remi-safe" list php[7-9][0-9].x86_64`

- Cài đặt php 7.4

`yum install -y yum-utils`
`yum-config-manager --enable remi-php74`
`yum install -y php php-mysqlnd php-fpm`

- Kiểm tra lại version của PHP
`php -v`
![Imgur](https://i.imgur.com/BIXTKgI.png)

## Khi cài đặt xong cần vào file www.conf để cấu hinh
- Sửa file mở tệp cấu hình /etc/php-fpm.d/www.conf và chỉnh sửa:

`vi /etc/php-fpm.d/www.conf`

- Tìm kiếm các dòng lệnh và thay thế apache =>nginx

`user=apache => user=nginx`
`group = apache => group=nginx`
![Imgur](https://i.imgur.com/6iFsu9k.png)

- Xác định vị trí lệnh listen, Theo mặc định php-fpm sẽ lắng nghe trên một máy chủ và cổng cụ thể qua TCP. Thay đổi cài đặt để nó lắng nghe trên socket file, vì điều này giúp cải thiện hiệu suất tổng thể của máy chủ.

Tìm đến dòng có chứa câu lệnh listen = 127.0.0.1:9000

Và sửa thành

listen = /var/run/php-fpm/php-fpm.sock;
![Imgur](https://i.imgur.com/lcRJLrM.png)
Thay đổi cài đặt của chủ sở hữu và nhóm cho tệp. Xác định vị trí lệnh listen.owner, listen.group, listen.mode. Loại bỏ dấu ; dấu trước ở đầu dòng. Sau đó thay đổi thành nginx.
![Imgur](https://i.imgur.com/ECeQufU.png)


- Khởi động lại php
`systemctl start php-fpm`

## Cấu hình Nginx để xử lý php
- Tạo một tệp để phục vụ như trang web PHP mặc định trên máy chủ này
`/etc/nginx/nginx.conf`

Sao chép định nghĩa sau và đổi tên server_name thành ip or tên miền
server {
    listen       80;
    server_name  [server_domain hoặc IP];

    root   /usr/share/nginx/html;
    index index.php index.html index.htm;

    location / {
        try_files $uri $uri/ =404;
    }
    error_page 404 /404.html;
    error_page 500 502 503 504 /50x.html;

    location = /50x.html {
        root /usr/share/nginx/html;
    }

    location ~ \.php$ {
        try_files $uri =404;
        fastcgi_pass unix:/var/run/php-fpm/php-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
}

![Imgur](https://i.imgur.com/lAWPiKQ.png) 

Lưu lại khi hoàn tất 

Khởi động lại nginx
`systemctl restart nginx`

## Kiểm tra xử lý php trên web
Tạo một tệp PHP mới được gọi là info.php tại thư mục `/usr/share/nginx/htmt`

`vi /usr/share/nginx/html/info.php`
![Imgur](https://i.imgur.com/Q8jQ214.png)

- lưu và đóng tệp
Nhập đường dẫn tại url : MyIp/info.php
![Imgur](https://i.imgur.com/e8yVtsO.png)

## Tạo cơ sở dữ liệu cho wordpress

- Đăng nhập vào CSDL
`mysql -u root -p`

Làm theo các bước sau
`CREATE USER test@localhost IDENTIFIED BY 'abcd@123';`
`GRANT ALL PRIVILEGES ON testwp.* TO test@localhost IDENTIFIED BY 'abcd@123';`
![Imgur](https://i.imgur.com/Bori2jU.png)

## Tải và cài đặt wordpress
Cài gói hỗ trợ php-gd: `yum -y install php-gd`
Cài đặt wget 

`yum install wget -y`
`wget http://wordpress.org/latest.tar.gz`

- Sau khi tải về thì giải nén 
`tar xvfz latest.tar.gz`

Copy các file trong thư mục sau WordPress tới đường dẫn /usr/share/nginx/html/ Như sau:

`cp -Rvf /root/wordpress/* /usr/share/nginx/html/`

### Cấu hình wordpress

Di chuyển tới thư mục chứa Wordpress

`cd /usr/share/nginx/html/`

File có cấu hình wp là file wp-config.php. Tuy nhiên ở đây chỉ có file wp-config-sample.php.Tiến hành cophy lại file cấu hình như sau:

`cp wp-config-sample.php wp-config.php`

Mở file wp-config.php với trình vi để sửa:

`vi wp-config.php`

![Imgur](https://i.imgur.com/P8EoNeV.png)

Khởi động lại nginx

`systemctl restart nginx`

![Imgur](https://i.imgur.com/4iawjw1.png)

![Imgur](https://i.imgur.com/rm0gvkO.png)
![Imgur](https://i.imgur.com/WtMPkn1.png)

