## Sử dụng virtual host điều hướng các request tới load balancer


### 1. Bài toán đặt ra 
- Qua từng thời kì sẽ có những website được tạo ra trên các nền tảng khác nhau. Sẽ tốn rất nhiều thời gian,... cho việc xây dựng lại toàn bộ website sử dụng cùng trên một nền tảng. Vấn đề đặt ra là ta chỉ có một địa chỉ ip public duy nhất đại diện cho cả công ty. Vậy làm thế nào để ta có thể giải quyết việc chỉ có một địa chỉ ip duy nhất ấy ta có thể tới được các website khác nhau qua nhiều domain website cùng sử dụng địa chỉ ip này?

- Lời giải cho bài toán trên là sử dụng virtual host để điều hướng các yêu cầu tới load balancer là một phương pháp phổ biến để cân bằng tải trong kiến trúc hệ thống phân tán. Khi sử dụng virtual host, các yêu cầu từ người dùng đến địa chỉ IP của máy chủ được gửi đến một tên miền ảo (virtual host), và sau đó được định tuyến tới load balancer.Load balancer có nhiệm vụ phân phối tải từ các máy chủ web khác nhau để giảm tải cho mỗi máy chủ và duy trì sự liên tục cho hệ thống. Nó có thể phân phối tải theo nhiều cách khác nhau, ví dụ như round-robin, phân phối dựa trên trọng số, hoặc phân phối dựa trên hiệu suất hiện tại của server.

![Imgur](https://i.imgur.com/OiDbxln.png)

### 2. Mô hình bài lab tạo virual host và cấu hình trỏ host

![Imgur](https://i.imgur.com/eridYMR.png)

#### Yêu cầu bài trước trong và sau khi làm bài lab
```
Mô hình bài lab đượcthực hiện trên centos7 , 3 máy chủ đều được cài đặt nginx
Yêu cầu show kq từng server sau khi cấu hình
Bài học rút ra sau khi hoàn thành xong bài lab 
```

#### 2.1 Cấu hình cài đặt nginx
- Các bước cài đặt nginx [Tại đây](Nginx.md)
***Lưu ý : Vào phần chi tiết cài đặt để xem bỏ qua phần trên***
#### 2.2 Cấu hình tạo virtual host
**Tại máy chủ backends01**
- Thêm file `/etc/nginx/conf.d/web1-backends01.conf`
`touch /etc/nginx/conf.d/web1-backends01.conf`
- Thêm nội dung vào file vừa tạo `vi /etc/nginx/conf.d/web1-backends01.conf`
```
 allow 192.168.202.101;
  deny all;
  server {
  	listen 80;
  	server_name www.web1-backends01.com web1-backends01.com;
  	root /usr/share/nginx/web1-backends01;
  		index index.php index.html index.cgi;
  	location / {
  	}
  }
```
![Imgur](https://i.imgur.com/VhDitIN.png)

- Tạo thư mục chứa nội dung web dùng cho kiểm tra kết quả
```
mkdir /usr/share/nginx/web1-backends01
vi /usr/share/nginx/web1-backends01/index.html
```
- Thêm nội dung sau vào file `index.html`
`<h1> web1-backends01 </h1>`
![Imgur](https://i.imgur.com/dLRmfwy.png)
- Khởi động lại nginx
`service nginx restart`

**Tại máy chủ backends02**
- Thêm file `/etc/nginx/conf.d/web1-backends02.conf`
`touch /etc/nginx/conf.d/web1-backends02.conf`
- Thêm nội dung vào file vừa tạo `vi /etc/nginx/conf.d/web2-backends02.conf`
```
 allow 192.168.202.101;
  deny all;
  server {
  	listen 80;
  	server_name www.web1-backends01.com web1-backends01.com;
  	root /usr/share/nginx/web1-backends01;
  		index index.php index.html index.cgi;
  	location / {
  	}
  }
```
![Imgur](https://i.imgur.com/pII4nmn.png)
- Tạo thư mục chứa nội dung web dùng cho kiểm tra kết quả
```
mkdir /usr/share/nginx/web2-backends02
vi /usr/share/nginx/web2-backends02/index.html
```
- Thêm nội dung sau vào file `index.html`
`<h1> web1-backends02 </h1>`
- Khởi động lại nginx
`service nginx restart`

#### 2.3 Cấu hình tại máy chủ load balancer
- Tạo 2 virtual host cho 2 máy chủ web backends01 và backends02
- Tạo virtual host vhost01.nginx.com cho máy chủ backends01
`vi /etc/nginx/conf.d/vhost01.nginx.com.conf`
Thêm nội dung sau vào: 
```
server {
  	listen 80;
    server_name www.vhost01.nginx.com vhost01.nginx.com;
  	
  	location / {
  		proxy_pass http://web1-backends01.com;
  	}
  }
```
- Tạo virtual host vhost02.nginx.com cho máy chủ backends02
`vi /etc/nginx/conf.d/vhost02.nginx.com.conf`
```
server {
  	listen 80;
  	server_name www.vhost02.nginx.com vhost02.nginx.com;
  	
  	location / {
  		proxy_pass http://web1-backends02.com;
  	}
  }
```

- Khởi động lại nginx

`service nginx restart`

#### 2.4 Cấu hình trỏ host để kiểm tra kết quả
- Thực hiện cấu hình tại máy chủ load balancer:

- Tiến hành cấu hình trỏ host:

- Sửa file /etc/hosts:

` vi /etc/hosts`
Thêm nội dung sau vào file:
```
  192.168.202.40 www.web1-backends01.com web1-backends01.com

  192.168.202.137 www.web2-backends02.com web2-backends02.com
```
![Imgur](https://i.imgur.com/Tlec00n.png)
Tiến hành cấu hình trỏ host trên client để kiểm tra bằng việc thêm nội dung sau vào file C:\Windows\System32\drivers\etc/hosts ( đối với Windows), tại /etc/hosts ( đối với Linux) trên client theo dạng
`192.168.202.101 www.vhost01.nginx.com vhost01.nginx.com www.vhost02.nginx.com vhost02.nginx.com`
![Imgur](https://i.imgur.com/IXfKGNT.png)

### Tiến hành kiểm tra và show kq
- Vào địa chỉ [vshost1.ng](http://vhost01.nginx.com/)
![Imgur](https://i.imgur.com/WO0KZXI.png)
Vào địa chỉ [vshost2.ng](http://vhost02.nginx.com/)
![Imgur](https://i.imgur.com/Awb0VYD.png)

### Bài học sau khi hoàn thành xong bài lab 
- Hiểu được cách hoạt động của virtual host và load balancer: Trong bài lab này,đã học cách sử dụng nginx để tạo và cấu hình các virtual host để phân tán các request đến các ứng dụng web khác nhau.

- Tạo và quản lý các virtual host: Bài lab này đã hướng dẫn cho bạn cách tạo và cấu hình các virtual host trên nginx. Điều này giúp cho việc phân tán các request trở nên dễ dàng hơn khi muốn chạy nhiều ứng dụng web trên cùng một Server. Có kiến thức về cách tạo và quản lý virtual host sẽ giúp tối ưu hóa hiệu suất của máy chủ của mình.

