## Cài đặt LAMP trên ubuntu ##
1. Cài đặt apache

 `apt install -y apache2 apache2-utils`
![Imgur](https://i.imgur.com/jAo5mIj.png)
2. Cài đặt MySQL , mariadb 
 `apt install -y mariadb-server mariadb-client`
 
 Cấu hình mysql
` mysql_secure_installation`
![Imgur](https://i.imgur.com/tl9ksR5.png)

3. Cài đặt php
`apt install -y php php-mysql libapache2-mod-php`
Mở file

`sudo nano /etc/apache2/mods-enabled/dir.conf`
Sửa lại nội dung của nó, cho index.php lên đầu.
![Imgur](https://i.imgur.com/Zr2vsz6.png)

- Khởi động lại apache 
`service apache2 restart`

 
 Kiểm tra php
 `php -v`
 ![Imgur](https://i.imgur.com/PX6ReUn.png)
![Imgur](https://i.imgur.com/tlR5qv1.png)


 
