# Wordpress Installation
# 1. LAMP
LAMP là từ viết tắt của Linux, Apache, MySQL và PHP/Perl/Python. Nó đề cập đến một nhóm phần mềm nguồn mở phổ biến thường được sử dụng để xây dựng và triển khai các trang web và ứng dụng web động. Chúng ta hãy xem xét kỹ hơn từng thành phần:
- **Linux:** LAMP được xây dựng dựa trên hệ điều hành Linux. Linux cung cấp một nền tảng ổn định và an toàn để lưu trữ các ứng dụng web. Nó cung cấp một loạt các bản phân phối (ví dụ: Ubuntu, CentOS, Debian) có thể được sử dụng để chạy ngăn xếp LAMP.

- **Apache:** Apache là một phần mềm máy chủ web xử lý các yêu cầu HTTP từ máy khách (trình duyệt web) và phục vụ các trang web trở lại chúng. Đây là một trong những máy chủ web được sử dụng rộng rãi nhất trên toàn cầu và cung cấp các tính năng như lưu trữ ảo, viết lại URL và mã hóa SSL/TLS.

- **MySQL:** MySQL là một hệ thống quản lý cơ sở dữ liệu quan hệ mã nguồn mở phổ biến (RDBMS). Nó được biết đến với độ tin cậy, hiệu suất và khả năng mở rộng. MySQL cho phép các nhà phát triển lưu trữ và truy xuất dữ liệu một cách hiệu quả, làm cho nó trở thành lựa chọn tuyệt vời cho các ứng dụng web yêu cầu chức năng cơ sở dữ liệu.

- **PHP/Perl/Python:** Chữ "P" trong LAMP đại diện cho ngôn ngữ kịch bản được sử dụng cho lập trình phía máy chủ. PHP là ngôn ngữ được sử dụng phổ biến nhất trong ngăn xếp LAMP, nhưng Perl và Python cũng là những lựa chọn khả thi. Các ngôn ngữ này cho phép tạo nội dung động và tương tác với cơ sở dữ liệu để xây dựng các ứng dụng web tương tác và mạnh mẽ.
# 2. Cài đặt Wordpress sử dụng Apache trên Ubuntu
- Cập nhật hệ thống
```bash
sudo apt-get update
sudo apt-get upgrade
```
- Cài đặt và khởi động apache2:
```bash
sudo apt-get install apache2
sudo systemctl start apache2
sudo systemctl enable apache2
```
- Cài đặt PHP và những extension cần thiết(ở đây sử dụng phiên bản mới nhất là php8.1)
```bash
sudo apt-get install php libapache2-mod-php php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc
``` 
- Khởi động lại Apache để tải lại các module của PHP
```bash
sudo systemctl restart apache2
```
- Cài đặt Wordpress:
    - Tải xuống và giải nén Wordpress:
    ```bash
    wget https://wordpress.org/latest.tar.gz
    tar -zxvf latest.tar.gz
    ```
    - Di chuyển file vừa giải nén vào thư mục web:
    ```bash
    sudo mv wordpress /var/www/html/
    ```
    - Cài đặt các quyền cho file và thư mục
    ```bash
    sudo chown -R www-data:www-data /var/www/html/wordpress
    sudo chmod -R 755 /var/www/html/wordpress
    ```
- Cài đặt Database cho Wordpress:
    - Cài đặt MySQL (hoặc MariaDB):
    ```bash
    ## MySQL
    sudo apt-get install mysql-server

    ### MariaDB
    sudo apt-get install mariadb-server
    ```
    - Cài đặt bảo mật cho MySQL(Sử dụng lệnh sau và làm theo các bước ở dưới):
    ```bash
    sudo mysql_secure_installation
    ```
    - Tạo database cho wordpress
    ```sql
    CREATE DATABASE wordpress;
    CREATE USER 'user'@'localhost' IDENTIFIED BY 'password';
    GRANT ALL PRIVILEGES ON wordpress.* TO 'user'@'localhost';
    FLUSH PRIVILEGES;
    EXIT;
    ```
    - Sửa file cấu hình Wordpress:
    ```bash
    cd /var/www/html/wordpress
    sudo cp wp-config-sample.php wp-config.php
    sudo nano wp-config.php
    ```
    - Tại file cấu hình, hãy sửa những thông tin của database để kết nối với database vừa tạo:
    ```php
    define('DB_NAME', 'wordpress');
    define('DB_USER', 'user');
    define('DB_PASSWORD', 'password');
    define('DB_HOST', 'localhost');
    ```
    - Lưu lại file và thoát
- Cấu hình Apache sử dụng thư mục của Wordpress
    - Truy cập vào file cấu hình của Apache:
    ```bash
    sudo nano /etc/apache2/sites-available/000-default.conf
    ```
    - Chỉnh sửa file cấu hình: thêm dòng lệnh sau vào dưới dòng `DocumentRoot`
    ```conf
    DocumentRoot /var/www/html/wordpress
    <Directory /var/www/html/wordpress>
        DirectoryIndex index.php
        AllowOverride All
        Require all granted
    </Directory>

    ```
    - Lưu lại file và thoát
    - Cài đặt ghi lại module cho Apache
    ```bash
    sudo a2enmod rewrite
    ```
    - Khởi động lại Apache áp dụng cấu hình
    ```bash
    sudo systemctl restart apache2
    ```
- Mở trình duyêt, nhập địa chỉ IP của server và cài đặt Wordpress.
    - Đầu tiên, chọn một ngôn ngữ để bắt đầu:

    ![noimg](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week2/worins/cholang.png)
    - Sau đó, điền đầy đủ các thông tin cần thiết như Tiêu đề trang, tài khoản quản trị,... và chọn **Install WordPress**:

    ![noimg](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week2/worins/getinfo.png)
    - Khi quá trình cài đặt kết thúc, chọn **Log In** và đăng nhập vào tài khoản:

    ![noimg](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week2/worins/login.png)
    - Truy cập vào trang dashboard của Wordpress, tại đây bạn có thể phát triển trang web của mình:

    ![noimg](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week2/worins/dashboard.png)
# 3. LEMP
LEMP là giải pháp thay thế cho LAMP, trong đó các thành phần khác nhau về máy chủ web và ngôn ngữ kịch bản được sử dụng. LEMP là viết tắt của Linux, Nginx, MySQL (hoặc MariaDB) và PHP/Perl/Python. Dưới đây là tổng quan về từng thành phần trong ngăn xếp LEMP:
- **Linux:** Tương tự như LAMP, LEMP được xây dựng trên hệ điều hành Linux, cung cấp nền tảng ổn định và an toàn để lưu trữ các ứng dụng web.
- **Nginx:** Nginx (phát âm là "engine-x") là một máy chủ web nhẹ, hiệu năng cao và máy chủ proxy ngược. Nó vượt trội trong việc xử lý các kết nối đồng thời và phục vụ hiệu quả nội dung tĩnh. Nginx được biết đến với việc sử dụng bộ nhớ thấp và khả năng xử lý lưu lượng truy cập cao, khiến nó trở thành lựa chọn phổ biến cho các trang web có lưu lượng truy cập lớn hoặc yêu cầu hiệu suất cao.
- **MySQL (hoặc MariaDB):** MySQL hoặc MariaDB được sử dụng làm hệ thống quản trị cơ sở dữ liệu quan hệ trong ngăn xếp LEMP. Cả hai đều là các RDBMS (relational database management system - Hệ quản trị cơ sở dữ liệu quan hệ) nguồn mở được áp dụng rộng rãi cung cấp các tính năng tương tự để lưu trữ và truy xuất dữ liệu một cách hiệu quả. MySQL và MariaDB được biết đến với độ tin cậy, hiệu suất và khả năng mở rộng, giống như trong ngăn xếp LAMP.
- **PHP/Perl/Python:** Như với LAMP, chữ "P" trong LEMP đại diện cho ngôn ngữ kịch bản được sử dụng cho lập trình phía máy chủ. PHP thường được sử dụng, nhưng Perl và Python cũng có thể được sử dụng. Các ngôn ngữ này cho phép tạo nội dung động và tương tác với cơ sở dữ liệu để xây dựng các ứng dụng web mạnh mẽ, giống như trong ngăn xếp LAMP.

Nhìn chung, LEMP cung cấp môi trường phát triển web tương tự như LAMP nhưng thay thế máy chủ web Apache bằng Nginx. Nginx tập trung vào hiệu suất và sử dụng tài nguyên hiệu quả khiến nó trở nên phổ biến để xử lý lưu lượng truy cập cao và phục vụ nội dung tĩnh. Giống như LAMP, LEMP cũng là mã nguồn mở và được hưởng lợi từ các cộng đồng tích cực để được hỗ trợ và cập nhật. Sự lựa chọn giữa LAMP và LEMP thường phụ thuộc vào các yêu cầu cụ thể của dự án và sở thích của nhóm phát triển.
# 4. Cài đặt Wordpress sử dụng Nginx trên Ubuntu
- Cập nhật hệ thống
```bash
sudo apt-get update
sudo apt-get upgrade
```
- Cài đặt và khởi động Nginx
```bash
sudo apt-get install nginx
sudo systemctl start nginx
sudo systemctl enable nginx
```
- Cài đặt PHP và những extension cần thiết(ở đây sử dụng phiên bản mới nhất là php8.1)
```bash
sudo apt-get install php-fpm php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc
```
- Cấu hình PHP-FPM:
    - Mở file cấu hình PHP-FPM:
    ```bash
    sudo nano /etc/php/8.1/fpm/php.ini
    ```
    - Tìm đến dòng cấu hình `cgi.fix_pathinfo` và set giá trị thành `0`:
    ```ini
    cgi.fix_pathinfo=0
    ```
    - Lưu và thoát file.
- Cài đặt Wordpress:
    - Tải xuống và giải nén Wordpress:
    ```bash
    wget https://wordpress.org/latest.tar.gz
    tar -zxvf latest.tar.gz
    ```
    - Di chuyển file vừa giải nén vào thư mục web:
    ```bash
    sudo mv wordpress /var/www/html/
    ```
- Cấu hình Wordpress
    - Cài đặt các quyền cho file và thư mục
    ```bash
    sudo chown -R www-data:www-data /var/www/html/wordpress
    sudo chmod -R 755 /var/www/html/wordpress
    ```
    - Cài đặt MySQL(hoặc MariaDB) và thêm database cho Wordpress
    ```sql
    CREATE DATABASE wordpress;
    GRANT ALL ON wordpress.* TO 'user'@'localhost' IDENTIFIED BY 'password';
    FLUSH PRIVILEGES;
    EXIT;
    ```
    - Sửa file cấu hình Wordpress:
    ```bash
    cd /var/www/html/wordpress
    sudo cp wp-config-sample.php wp-config.php
    sudo nano wp-config.php
    ```
    - Tại file cấu hình, hãy sửa những thông tin của database để kết nối với database vừa tạo:
    ```php
    define('DB_NAME', 'wordpress');
    define('DB_USER', 'user');
    define('DB_PASSWORD', 'password');
    define('DB_HOST', 'localhost');
    ```
    - Lưu lại file và thoát
- Cấu hình Nginx sử dụng PHP-FPM:
    - Mở file cấu hình mặc định của Nginx:
    ```bash
    sudo nano /etc/nginx/sites-available/default
    ```
    - Thay đổi cấu hình cũ thành cấu hình dưới đây
    ```bash
    server {
        listen 80;
        server_name localhost;
        root /var/www/html/wordpress;
        index index.php index.html index.htm;
        location / {
            try_files $uri $uri/ /index.php?$args;
        }
        location ~ \.php$ {
            include snippets/fastcgi-php.conf;
            fastcgi_pass unix:/run/php/php8.1-fpm.sock;
        }
        location ~ /\.ht {
            deny all;
        }
    }
    ```
    - Mở trình duyệt, nhập địa chỉ IP của bạn và cài đặt Wordpress(Tương tự như phần cài trên Apache).