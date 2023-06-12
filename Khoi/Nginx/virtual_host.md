
## virtual_host(server Block)
### 1. Định nghĩa 
![Imgur](https://i.imgur.com/iwHXO8I.png)
- Virtual Host (còn được gọi là Virtual Hosting hoặc vhost) là một khái niệm trong việc cấu hình máy chủ web để phục vụ nhiều tên miền hoặc nhiều trang web trên cùng một máy chủ vật lý. Virtual Host cho phép bạn chia sẻ tài nguyên máy chủ vật lý (như băng thông, dung lượng lưu trữ) và chạy nhiều trang web độc lập trên cùng một máy chủ.



- Khi sử dụng Virtual Host, mỗi tên miền hoặc trang web sẽ có một cấu hình riêng, có thể có các tập tin và thư mục riêng, và có thể được quản lý và cấu hình độc lập. Khi người dùng truy cập vào tên miền hoặc địa chỉ IP tương ứng, máy chủ sẽ nhận diện và phục vụ nội dung từ Virtual Host tương ứng.


### 2.Ưu điểm nhược điểm của Virtual Host:
#### 2.1 Ưu điểm
- Chia sẻ tài nguyên: Virtual Host cho phép bạn chia sẻ tài nguyên máy chủ vật lý giữa nhiều trang web hoặc tên miền, giúp tận dụng tối đa khả năng của máy chủ.

- Quản lý độc lập: Mỗi Virtual Host có thể được quản lý và cấu hình riêng biệt, giúp dễ dàng xây dựng và quản lý nhiều trang web độc lập trên cùng một máy chủ.

- Tích hợp linh hoạt: Virtual Host cho phép bạn chạy nhiều ứng dụng web khác nhau, sử dụng ngôn ngữ và công nghệ khác nhau trên cùng một máy chủ.

-Tiết kiệm chi phí: Thay vì phải sử dụng nhiều máy chủ vật lý cho mỗi trang web hoặc tên miền, Virtual Host giúp tiết kiệm chi phí về phần cứng và quản lý hệ thống.
- Hỗ trợ nhiều tên miền: Virtual Host cho phép chạy nhiều trang web với các tên miền khác nhau trên cùng một máy chủ, đáp ứng nhu cầu của các tổ chức hoặc cá nhân có nhiều trang web riêng biệt.
#### 2.1 Nhược điểm 
- Hiệu suất: Khi có nhiều Virtual Host chạy trên cùng một máy chủ, hiệu suất của máy chủ có thể bị ảnh hưởng do việc chia sẻ tài nguyên và quản lý nhiều trang web.

- Bảo mật: Nếu cấu hình không chính xác, một lỗ hổng bảo mật trên một Virtual Host có thể ảnh hưởng đến các Virtual Host khác trên cùng máy chủ.

- Quản lý phức tạp: Với nhiều Virtual Host,


 ### 3. Bài lab demo cấu hình virtual_host

![Imgur](https://i.imgur.com/wxUKFPC.png)
```
- Yêu cầu bài lab cấu hình trên hệ điều hành centOS7 
- Sau khi cấu hình xong hiểu rõ bản chất , cách thức cấu hình virtual host 
- Bài học rút ra sau khi thực hiện bài lab 
```
 
#### 3.1 Cài đặt nginx 
- Các bước cài đặt nginx [Tại đây](Nginx.md)
***Lưu ý : Vào phần chi tiết cài đặt để xem bỏ qua phần trên***
#### 3.2 Cài đặt nginx cho domain chính 

- Thực hiện vào file cấu hình của nginx để chỉnh sửa 
` vi /etc/nginx/nginx.conf`

```
Thực hiện bỏ phần dấu gạch của dòng server_name _;Thay _ bằng tên miền mà mình cần sử dụng
```
![Imgur](https://i.imgur.com/EvKqY1U.png)

#### 3.3 Cấu hình tạo ra các virtual host

**Tạo virtual host thứ nhất**
` vi /etc/nginx/conf.d/vhost1.com.conf`
- Tiếp theo ta cần thêm nội dung cấu hình cho file vừa tạo trên với nội dung:
```
 server {
          listen      80;
          server_name     vhost1.com www.vhost1.com;
          access_log      /var/log/nginx/access-vhost1.com.log;
          error_log       /var/log/nginx/error-vhost1.com.log;
          root    /usr/share/nginx/vhost1.com;
          index   index.php index.html index.htm;
      }
```
- Tạo thư mục chứa website cho virtual host này:
```
   mkdir /usr/share/nginx/vhost1.com
  chown nginx:nginx -R /usr/share/nginx/vhost1.com
  ```
- Tạo một file index.html để kiểm tra kết quả:
 `vi /usr/share/nginx/vhost1.com/index.html`

 - Thêm vào file nội dung sau:
 
 ```
 <DOCTYPE html>
  <html>
    <head>
      <title>vhost1.com</title>
    </head>
    <body>
      <h1>chao mung ban den voi vhost1</h1>
    </body>
  </html>

 ```
 **Tạo virtual host thứ hai**
 `vi /etc/nginx/conf.d/vhost2.com.conf`

 - Tiếp theo ta cần thêm nội dung cấu hình cho file vừa tạo trên với nội dung:
 ```
   server {
          listen      80;
          server_name     vhost2.com www.vhost2.com;
          access_log      /var/log/nginx/access-vhost2.com.log;
          error_log       /var/log/nginx/error-vhost2.com.log;
          root    /usr/share/nginx/vhost2.com;
          index   index.php index.html index.htm;
            }
```
- Tạo thư mục chứa website cho virtual host này:
```
mkdir /usr/share/nginx/vhost2.com
chown nginx:nginx -R /usr/share/nginx/vhost2.com
```
- Tạo một file index.html để kiểm tra kết quả:
 `vi /usr/share/nginx/vhost2.com/index.html`
 - Thêm vào file nội dung sau:
```
<DOCTYPE html>
  <html>
    <head>
      <title>vhost2</title>
    </head>
    <body>
      <h1>chao mung ban den voi vhost2</h1>
    </body>
  </html>
```
- Sau khi hoàn thành restart lại nginx
`nginx -s reload`
#### 3.4 Cấu hình file host trên window 
`C:\Windows\System32\drivers\etc/hosts `
`192.168.202.101		khoikhoi.xyz vhost1.com vhost2.com`
![Imgur](https://i.imgur.com/LezCvVP.png)

### 4.Kiểm tra kết quả
- Khi ta truy cập vào khoikhoi.xyz
![Imgur](https://i.imgur.com/fRwIIgO.png) 

- Khi ta truy cập vào vshost1.com
![Imgur](https://i.imgur.com/Zc4XB93.png)
- Khi ta truy cập vào vshost2.com
![Imgur](https://i.imgur.com/puUHTQx.png)



### 5. Bài học rút ra cho bản thân
- Hiểu rõ được cách thức hoạt động của virtual host . Cách cấu hình và quản lý nhiều trang web trên cùng một máy chủ, tận dụng tài nguyên một cách hiệu quả.
- Học cách chỉ định các tên miền, thư mục gốc và các cài đặt khác để phân chia và xử lý các yêu cầu đến từ các trang web khác nhau.
