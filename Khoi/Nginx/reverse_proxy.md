## Cấu hình reverse proxy 
### 1. Định nghĩa 
- Reverse proxy là một loại proxy server (máy chủ proxy) được sử dụng để điều hướng các yêu cầu từ người dùng đ ến các máy chủ đích trong mạng nội bộ. Ngược lại với forward proxy (proxy server tiến), reverse proxy hoạt động như một trung gian giữa máy chủ và người dùng cuối.

- Mục đích chính của reverse proxy là bảo vệ các máy chủ đằng sau nó bằng cách ẩn thông tin về các máy chủ thực tế khỏi người dùng cuối. Khi người dùng gửi yêu cầu, nó sẽ được định tuyến thông qua reverse proxy, và sau đó reverse proxy sẽ chuyển tiếp yêu cầu đó đến máy chủ đích thích hợp. Do đó, người dùng không thấy thông tin về máy chủ thực tế và các máy

### 2.Ưu nhược điểm của reverse proxy 
#### 2.1. Ưu điểm của reverse proxy:
- Bảo mật: Reverse proxy cung cấp một lớp bảo mật bổ sung bằng cách che giấu thông tin về cơ sở hạ tầng nội bộ và ngăn chặn các cuộc tấn công trực tiếp vào các máy chủ. Nó cũng cho phép triển khai các giải pháp bảo mật như giải mã và mã hóa SSL.
- Cân bằng tải: Reverse proxy có khả năng phân phối tải giữa các máy chủ đích, giúp tăng hiệu suất và khả năng chịu tải của hệ thống. Bằng cách phân phối yêu cầu đến các máy chủ khác nhau, reverse proxy giúp tránh quá tải một máy chủ duy nhất.
- Caching: Reverse proxy có thể lưu trữ bộ nhớ cache để phục vụ các tài nguyên tĩnh, giảm thời gian tải trang và tăng tốc độ truy cập. Việc sử dụng cache giúp giảm tải cho máy chủ đích và cải thiện trải nghiệm người dùng.
- Giám sát và quản lý: Reverse proxy cung cấp khả năng giám sát yêu cầu và lưu trữ nhật ký truy cập chi tiết. Điều này giúp trong việc phân tích và quản lý hệ thống, như đánh giá hiệu suất, xác định sự cố và tối ưu hóa cấu hình.
- Kiểm soát truy cập: Reverse proxy cho phép thiết lập các quy tắc kiểm soát truy cập để kiểm soát quyền truy cập vào các máy chủ đích. Điều này giúp bảo vệ các tài nguyên và ứng dụng khỏi truy cập trái phép hoặc không được ủy quyền.

#### 2.2 Nhược điểm của reverse proxy:

- Điểm hết hạn: Reverse proxy có thể trở thành một điểm hết hạn trong hệ thống, khiến cho toàn bộ ứng dụng bị tạm dừng nếu reverse proxy gặp sự cố.

- Độ trễ: Việc thêm một lớp trung gian (reverse proxy) có thể làm gia tăng độ trễ trong quá trình xử lý yêu cầu. Điều này có thể ảnh hưởng đến thời gian phản hồi và hiệu suất của ứng dụng.

- Độ phức tạp: Triển khai và quản lý khó và chuyên sâu 
- Quản lý bảo trì: Reverse proxy cần được quản lý và duy trì đều đặn để đảm bảo tính khả dụng và hiệu suất của hệ thống.

- Phụ thuộc vào một điểm duy nhất: Một reverse proxy đơn lẻ có thể trở thành một điểm yếu của hệ thống, và nếu nó gặp sự cố hoặc bị quá tải, toàn bộ hệ thống có thể bị ảnh hưởng. Để tránh điều này, có thể triển khai nhiều reverse proxy song song 

 ### 3.Cấu hình Nginx làm reverse proxy cho apache .
 #### 3.1 Mô hình bài lab
 ![Imgur](https://i.imgur.com/UFGyjvr.png)

 - Yêu cầu cần 2 máy centos7 có kết nối ra ngoài internet
 - Sau khi hoàn thành xong bài lab hiểu được rõ về reverse proxy 
 - Nắm được cách cấu hình về reveser proxy 

 - ##### 3.2 Cấu hình cài đặt trên máy nginx
- Thêm các repo của nginx 
`yum install epel-release`
- Cài đặt nginx
`yum install -y nginx`
- Sau khi tải về muốn khởi động nginx
- `systemctl start nginx`

- Cấu hình firewall và restart lại dịch vụ:
`sudo firewall-cmd --permanent --zone=public --add-service=http `
`sudo firewall-cmd --permanent --zone=public --add-service=https`
`sudo firewall-cmd --reload`

- Dùng trình soạn thảo vi sửa file cấu hình của nginx

` vi /etc/nginx/nginx.conf`
Sửa file cấu hình server theo dưới : 
 server {
        listen       80;
        listen       [::]:80;
        server_name  _;

        proxy_redirect           off;
        proxy_set_header         X-Real-IP $remote_addr;
        proxy_set_header         X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header         Host $http_host;

        location / {
            proxy_pass http://192.168.202.40/;
        }
![Imgur](https://i.imgur.com/hKu7IKs.png)

Trong đó 192.168.202.40 là địa chỉ của apache 
Restart lại nginx :

`systemctl restart nginx `


##### 3.23 Cấu hình cài đặt trên máy apache

- Cài đặt apache :
`yum install httpd httpd-devel -y`

- Dùng trình soạn thảo `vi` mở file `/etc/httpd/conf/httpd.conf`
`vi /etc/httpd/conf/httpd.conf `

- Tìm đến dòng 196 và sửa lại thành 

`LogFormat "\"%{X-Forwarded-For}i\" %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined `
![Imgur](https://i.imgur.com/dAjpW8d.png)

- Ý nghĩa của câu lệnh trên là
Đây là một định dạng chuỗi log của Apache HTTP Server được gọi là "combined". Cụ thể, nó sẽ ghi lại các thông tin sau đây:

```Địa chỉ IP của client được truyền vào qua header X-Forwarded-For (" % {X-Forwarded-For} i ")
Tên máy chủ từ khách hàng yêu cầu (" % l ")
Tên người dùng đăng nhập (nếu có) (" % u ")
Thời điểm nhận yêu cầu từ khách hàng (" % t ")
Yêu cầu HTTP được gửi đến máy chủ (" % r ")
Mã trạng thái HTTP trả về cho yêu cầu (" %> s ")
Số byte được gửi từ máy chủ đến khách hàng (" % b ")
Header Referer (nếu có) (" % {Referer} i ")
Header User-Agent (" % {User-Agent} i ")
Việc định dạng log này giúp quản trị viên web có thể theo dõi và phân tích hoạt động của các yêu cầu HTTP đến máy chủ.
```

- Restart lại apache :

`systemctl restart httpd `

### 4. Kiểm tra
- Truy cập vào địa chỉ nginx 
http://192.168.202.101/

Kết quả nhận được 
![Imgur](https://i.imgur.com/Twt5icv.png)